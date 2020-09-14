//
//  ProductContentViewController.swift
//  Gumroad 2.0
//
//  Created by Nathan Chan on 9/13/20.
//

import UIKit

class ProductContentViewController: UIViewController, StoryboardIdentifiable {
    static var storyboardName: StoryboardName = .main

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productCreatorLabel: UILabel!
    @IBOutlet weak var contentStackView: UIStackView!

    var product: Product?
    var content: [Content] = [] {
        didSet {
            for item in content {
                let productContentView = ProductContentView.instanceFromNib() as! ProductContentView
                productContentView.configure(with: item)
                self.contentStackView.addArrangedSubview(productContentView)
                productContentView.heightAnchor.constraint(equalToConstant: 80).isActive = true
                productContentView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor).isActive = true
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let product = product else { return }

        productImage.image(fromUrl: product.imageUrlString)
        productLabel.text = product.name
        productCreatorLabel.text = "By \(product.creatorName)"

        NetworkManager.shared.getContent(for: product.id) { content in
            self.content = content
        }
    }

    @IBAction func backClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
