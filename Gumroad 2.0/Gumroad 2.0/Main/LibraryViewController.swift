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
    @IBOutlet weak var filterStackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!

    var productsToShow: [Product] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    var allProducts: [Product] = []

    var searchText: String?

    var creatorFilterButtons: [CreatorFilterButton] = []

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

        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        filterStackView.insertSubview(backgroundView, at: 0)
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: filterStackView.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: filterStackView.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: filterStackView.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: filterStackView.bottomAnchor)
        ])
        filterStackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        filterStackView.isLayoutMarginsRelativeArrangement = true

        self.tableView.keyboardDismissMode = .onDrag

        NetworkManager.shared.getOwnedProducts() { products in
            self.allProducts = products

            self.configureCreatorStackView(labelText: "All Creators", creatorName: "All Creators", buttonType: .all, isPreselected: true)

            var creatorCountMap: [String: Int] = [:]
            for product in self.allProducts {
                if creatorCountMap[product.creatorName] != nil {
                    creatorCountMap[product.creatorName]! += 1
                } else {
                    creatorCountMap[product.creatorName] = 1
                }
            }

            for creatorName in Array(creatorCountMap.keys).sorted(by: { $0 < $1 }) {
                self.configureCreatorStackView(labelText: "\(creatorName) (\(creatorCountMap[creatorName]!))", creatorName: creatorName, buttonType: .creator)
            }

            self.configureCreatorStackView(labelText: "Show archived only", creatorName: "", buttonType: .archived)

            self.applyFilters()
        }
    }

    func configureCreatorStackView(labelText: String, creatorName: String, buttonType: CreatorFilterButtonType, isPreselected: Bool = false) {
        let creatorStackView = UIStackView(frame: .zero)
        creatorStackView.translatesAutoresizingMaskIntoConstraints = false
        creatorStackView.axis = .horizontal
        creatorStackView.distribution = .fill
        creatorStackView.alignment = .center
        creatorStackView.isLayoutMarginsRelativeArrangement = true

        let creatorNameLabel = UILabel(frame: .zero)
        creatorNameLabel.text = labelText
        creatorNameLabel.numberOfLines = 1
        creatorNameLabel.textColor = .gray
        creatorNameLabel.textAlignment = .left
        creatorNameLabel.font = UIFont(name: "HelveticaNeue", size: 16)
        creatorNameLabel.adjustsFontSizeToFitWidth = true
        creatorNameLabel.sizeToFit()

        creatorStackView.addArrangedSubview(creatorNameLabel)

        let checkmarkButton = CreatorFilterButton(creatorName: creatorName, type: buttonType)
        checkmarkButton.addTarget(self, action: #selector(self.creatorFilterButtonClicked(sender:)), for: .touchUpInside)
        checkmarkButton.setImage(isPreselected ? CreatorFilterButton.filledUIImage : CreatorFilterButton.emptyUIImage, for: .normal)
        checkmarkButton.tag = isPreselected ? 1 : 0
        checkmarkButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        checkmarkButton.widthAnchor.constraint(equalToConstant: 25).isActive = true

        creatorStackView.addArrangedSubview(checkmarkButton)

        self.creatorFilterButtons.append(checkmarkButton)

        self.filterStackView.addArrangedSubview(creatorStackView)
    }

    func applyFilters() {
        let filteredProducts: [Product]
        if let allButton = creatorFilterButtons.first(where: { $0.type == .all }),
            allButton.tag == 1 {
            filteredProducts = allProducts.filter { !$0.archived }
        } else if let archivedButton = creatorFilterButtons.first(where: { $0.type == .archived }),
            archivedButton.tag == 1 {
            filteredProducts = allProducts.filter { $0.archived }
        } else {
            let selectedCreatorNames = Set(creatorFilterButtons
                .filter { $0.type == .creator && $0.tag == 1 }
                .map { $0.creatorName })

            filteredProducts = allProducts.filter { !$0.archived && selectedCreatorNames.contains($0.creatorName) }
        }

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
        filterStackView.isHidden.toggle()
    }

    @objc func creatorFilterButtonClicked(sender: CreatorFilterButton) {
        sender.tag = (sender.tag + 1) % 2
        sender.setImage(sender.tag == 0 ? CreatorFilterButton.emptyUIImage : CreatorFilterButton.filledUIImage, for: .normal)
        if sender.type == .all || sender.type == .archived {
            for button in creatorFilterButtons.filter({ $0.type != sender.type }) {
                button.tag = 0
                button.setImage(CreatorFilterButton.emptyUIImage, for: .normal)
            }
        } else {
            for button in creatorFilterButtons.filter({ $0.type == .all || $0.type == .archived }) {
                button.tag = 0
                button.setImage(CreatorFilterButton.emptyUIImage, for: .normal)
            }
        }

        applyFilters()
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
        filterStackView.isHidden = true
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = ProductContentViewController.instantiate()
        vc.product = productsToShow[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        filterStackView.isHidden = true
    }
}

extension LibraryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterStackView.isHidden = true
        self.searchText = searchText == "" ? nil : searchText
        applyFilters()
    }

    func scrollToFirstRow() {
        if !productsToShow.isEmpty {
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}
