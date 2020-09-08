//
//  Utilities.swift
//  Gumroad 2.0
//
//  Created by Nathan Chan on 9/7/20.
//

import Foundation

enum Globals {
    static let AuthTokenUserDefaultsKey: String = "authToken"
}

enum MockData {
    static let products: [ProductMockData] = [
        ProductMockData(
            name: "POST — A Short Story of No Consequence at All (PDF + AUDIOBOOK)",
            creatorName: "Shea Serrano",
            imageUrlString: "https://static-2.gumroad.com/res/gumroad/3015050709675/asset_previews/fbf4925553912ef3aba708c2a380056e/retina/POST_20_E2_80_94_20Cover.jpg",
            content: [
                ContentMockData(
                    name: "POST — A Short Story of No Consequence at All (PDF)",
                    sizeKb: 132,
                    urlString: ""
                ),
                ContentMockData(
                    name: "POST — A Short Story of No Consequence at All (AUDIOBOOK)",
                    sizeKb: 59832,
                    urlString: ""
                )
            ]
        ),
        ProductMockData(
            name: "CONFERENCE ROOM, FIVE MINUTES — Ten Illustrated Essays About The Office",
            creatorName: "Shea Serrano",
            imageUrlString: "https://static-2.gumroad.com/res/gumroad/3015050709675/asset_previews/dd472bffe57a0a49860bc926f01dd76f/retina/Screen_20Shot_202020-07-18_20at_2011.52.37_20AM.png",
            content: [
                ContentMockData(
                    name: "CONFERENCE ROOM, FIVE MINUTES — Ten Illustrated Essays About The Office (PDF)",
                    sizeKb: 245,
                    urlString: ""
                )
            ]
        ),
    ]
}

struct ProductMockData {
    var name: String
    var creatorName: String
    var imageUrlString: String
    var content: [ContentMockData]
}

struct ContentMockData {
    var name: String
    var sizeKb: Int
    var urlString: String
}
