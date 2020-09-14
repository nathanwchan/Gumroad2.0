//
//  Content.swift
//  Gumroad 2.0
//
//  Created by Nathan Chan on 9/8/20.
//

import Foundation

struct Content {
    var id: String
    var productId: String
    var name: String
    var sizeKb: Int
    var url: URL?

    func isViewable() -> Bool {
        return Set(["pdf", "mp3", "mp4"]).contains(url?.absoluteString.components(separatedBy: ".").last?.lowercased() ?? "unknown")
    }
}
