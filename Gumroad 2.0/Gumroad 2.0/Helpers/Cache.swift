//
//  Cache.swift
//  Gumroad 2.0
//
//  Created by Nathan Chan on 9/10/20.
//

import UIKit

class Cache {
    static let shared = Cache()

    private let cache = NSCache<NSString, UIImage>()
    var session = URLSession.shared

    func imageFor(url: URL, completionHandler: @escaping (_ image: UIImage?) -> Void) {
        if let imageInCache = self.cache.object(forKey: url.absoluteString as NSString)  {
            completionHandler(imageInCache)
            return
        }

        let task = self.session.dataTask(with: url) { data, response, error in
            if let _ = error {
                completionHandler(nil)
                return
            }

            if let image = UIImage(data: data!) {
                self.cache.setObject(image, forKey: url.absoluteString as NSString)
                completionHandler(image)
            }
        }

        task.resume()
    }
}
