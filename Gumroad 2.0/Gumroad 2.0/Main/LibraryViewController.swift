//
//  LibraryViewController.swift
//  Gumroad 2.0
//
//  Created by Nathan Chan on 9/7/20.
//

import UIKit

class LibraryViewController: UIViewController, StoryboardIdentifiable {
    static var storyboardName: StoryboardName = .main

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var products: [Product] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
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
            self.products = products
            self.allProducts = products
        }
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
        productCell.configure(with: products[indexPath.row])
        return productCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
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
            products = allProducts
            scrollToFirstRow()
        } else {
            products = allProducts.filter {
                $0.name.lowercased().contains(searchText.lowercased()) || $0.creatorName.lowercased().contains(searchText.lowercased())
            }
        }
    }

    func scrollToFirstRow() {
        if !products.isEmpty {
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}
