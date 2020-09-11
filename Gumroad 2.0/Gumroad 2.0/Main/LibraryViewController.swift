//
//  LibraryViewController.swift
//  Gumroad 2.0
//
//  Created by Nathan Chan on 9/7/20.
//

import UIKit

class LibraryViewController: UIViewController, StoryboardIdentifiable, ProductTableViewCellDelegate {
    static var storyboardName: StoryboardName = .main

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var productsToShow: [Product] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    var filteredProducts: [Product] = []
    var allProducts: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self

        // remove separator lines between empty rows
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)

        // dynamic cell height based on inner content
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 50

        self.searchBar.delegate = self

        self.tableView.keyboardDismissMode = .onDrag

        NetworkManager.shared.getOwnedProducts() { products in
            self.allProducts = products
            self.applyFilters()
        }
    }

    func applyFilters(with searchText: String? = nil) {
        filteredProducts = allProducts.filter { !$0.archived } // for now

        if let searchText = searchText {
            productsToShow = filteredProducts.filter {
                $0.name.lowercased().contains(searchText.lowercased()) || $0.creatorName.lowercased().contains(searchText.lowercased())
            }
        } else {
            productsToShow = filteredProducts
        }
    }

    func showOptions(product: Product) {
        let actionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if !product.archived {
            let favoriteAction = UIAlertAction(title: "Add to Favorites", style: .default) { _ in
                // TODO
            }
            actionMenu.addAction(favoriteAction)
        }

        let title = product.archived ? "Unarchive from Library" : "Archive from Library"
        let style: UIAlertAction.Style = product.archived ? .default : .destructive
        let archiveAction = UIAlertAction(title: title, style: style) { _ in
            NetworkManager.shared.toggleArchive(for: product.id) { product in
                if let product = product {
                    for i in 0 ..< self.allProducts.count {
                        if self.allProducts[i].id == product.id {
                            self.allProducts[i].archived = product.archived
                            self.applyFilters()
                            break
                        }
                    }
                }
            }
        }
        actionMenu.addAction(archiveAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        actionMenu.addAction(cancelAction)

        present(actionMenu, animated: true, completion: nil)
    }

    @IBAction func filterClicked(_ sender: Any) {
    }

    @IBAction func logoutClicked(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: Globals.AuthTokenUserDefaultsKey)
        dismiss(animated: true, completion: nil)
    }
}

extension LibraryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let productCell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell else {
            fatalError("The dequeued cell is not an instance of ProductTableViewCell.")
        }
        productCell.delegate = self
        productCell.configure(with: productsToShow[indexPath.row])
        return productCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsToShow.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

    }
}

extension LibraryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            productsToShow = allProducts
            scrollToFirstRow()
        } else {
            applyFilters(with: searchText)
        }
    }

    func scrollToFirstRow() {
        if !productsToShow.isEmpty {
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}
