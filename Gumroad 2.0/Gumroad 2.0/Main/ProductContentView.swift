//
//  ProductContentView.swift
//  Gumroad 2.0
//
//  Created by Nathan Chan on 9/13/20.
//


import UIKit

class ProductContentView: UIView {

    @IBOutlet weak var formatImage: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!

    var content: Content?

    class func instanceFromNib() -> UIView {
        return UINib(nibName: "ProductContentView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }

    func configure(with content: Content) {
        self.content = content

        let image = UIImage(named: "\(content.format.rawValue).png")
        formatImage.image = image
        contentLabel.text = content.name
        sizeLabel.text = content.sizeKb < 1024 ? "\(content.sizeKb) KB" : "\(String(format: "%.1f", Float(content.sizeKb) / 1024)) MB"
    }

}
