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

    func configure(with product: Product) {
        let data = try? Data(contentsOf: product.image!)
        productImage.image = UIImage(data: data!)

        nameLabel.text = product.name
        creatorLabel.text = "By \(product.creatorName)"
    }
}
