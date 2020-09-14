//
//  ProductContentView.swift
//  Gumroad 2.0
//
//  Created by Nathan Chan on 9/13/20.
//


import UIKit

class ProductContentView: UIView {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!

    var content: Content?

    class func instanceFromNib() -> UIView {
        return UINib(nibName: "ProductContentView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }

    func configure(with content: Content) {
        self.content = content

        contentLabel.text = content.name
        sizeLabel.text = "\(content.sizeKb) KB"
    }

}
