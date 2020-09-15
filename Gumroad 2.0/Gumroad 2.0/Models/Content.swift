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

    var format: ContentFormat {
        if let formatString = url?.absoluteString.components(separatedBy: ".").last?.lowercased() {
            return ContentFormat(rawValue: formatString) ?? .file
        }
        return .file
    }

    func isViewable() -> Bool {
        let validFormats: Set<ContentFormat> = [.pdf, .mp3, .mp4] // for now
        return validFormats.contains(format)
    }
}

enum ContentFormat: String {
    case pdf
    case mp3
    case mp4
    case epub
    case zip
    case file
}
