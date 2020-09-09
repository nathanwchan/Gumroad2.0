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

    private var allProducts: [Product]
    private var allContent: [Content]

    private init() {
        allProducts = []
        allContent = []

        for product in MockData.products {
            let id = UUID().uuidString
            allProducts.append(
                Product(
                    id: id,
                    name: product.name,
                    creatorName: product.creatorName,
                    image: URL(string: product.imageUrlString),
                    archived: false
                )
            )
            for content in product.content {
                allContent.append(
                    Content(
                        id: UUID().uuidString,
                        productId: id,
                        name: content.name,
                        sizeKb: content.sizeKb,
                        url: URL(string: content.urlString)
                    )
                )
            }
        }
    }

    /* END - FOR MOCK PURPOSES ONLY */

    func getOwnedProducts(completion: @escaping ([Product]) -> Void) {
        // replace with API call
        completion(allProducts)
    }

    func getContent(for productId: String, completion: @escaping ([Content]) -> Void) {
        // replace with API call
        completion(allContent)
    }
}
