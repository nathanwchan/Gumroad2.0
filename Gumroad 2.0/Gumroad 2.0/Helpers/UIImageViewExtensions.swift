//
//  UIImageViewExtensions.swift
//  Gumroad 2.0
//
//  Created by Nathan Chan on 9/10/20.
//

import UIKit

extension UIImageView {
    public func image(fromUrl urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Couldn't create URL from \(urlString)")
            return
        }
        
        Cache.shared.imageFor(url: url) { image in
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
