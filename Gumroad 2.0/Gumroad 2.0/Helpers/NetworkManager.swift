//
//  NetworkManager.swift
//  Gumroad 2.0
//
//  Created by Nathan Chan on 9/8/20.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    /* BEGIN - FOR MOCK PURPOSES ONLY */

    var allProducts: [Product]
    var allContent: [Content]

    private init() {
        allProducts = []
        allContent = []

        let id = UUID().uuidString
        allProducts.append(
            Product(id: id,
                name: "POST — A Short Story of No Consequence at All (PDF + AUDIOBOOK)",
                creatorName: "Shea Serrano",
                image: URL(string: "https://static-2.gumroad.com/res/gumroad/3015050709675/asset_previews/fbf4925553912ef3aba708c2a380056e/retina/POST_20_E2_80_94_20Cover.jpg"),
                archived: false)
        )
        allContent.append(
            Content(id: UUID().uuidString,
                    productId: id,
                    name: "POST — A Short Story of No Consequence at All (PDF)",
                    sizeKb: 132,
                    url: URL(string: ""))
        )
        allContent.append(
            Content(id: UUID().uuidString,
                    productId: id,
                    name: "POST — A Short Story of No Consequence at All (AUDIOBOOK)",
                    sizeKb: 59832,
                    url: URL(string: ""))
        )
    }

    /* END - FOR MOCK PURPOSES ONLY */

    func getOwnedProducts(id: String, completion: @escaping ([Product]) -> Void) {
        // replace with API call
        completion(allProducts)
    }

    func getContent(for productId: String, completion: @escaping ([Content]) -> Void) {
        // replace with API call
        completion(allContent)
    }
}
