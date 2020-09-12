//
//  ProductTableViewCell.swift
//  Gumroad 2.0
//
//  Created by Nathan Chan on 9/8/20.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!

    var product: Product?
    var delegate: ProductTableViewCellDelegate?

    func configure(with product: Product) {
        self.product = product

        productImage.image = nil
        productImage.image(fromUrl: product.imageUrlString)

        nameLabel.text = product.name
        creatorLabel.text = "By \(product.creatorName)"
    }

    @IBAction func ellipsisClicked(_ sender: Any) {
        guard let product = product else { return }
        delegate?.showOptions(product: product)
    }
}

protocol ProductTableViewCellDelegate {
    func showOptions(product: Product)
}

