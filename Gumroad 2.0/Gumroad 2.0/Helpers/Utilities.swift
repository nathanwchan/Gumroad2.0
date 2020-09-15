//
//  Utilities.swift
//  Gumroad 2.0
//
//  Created by Nathan Chan on 9/7/20.
//

import Foundation

enum Globals {
    static let AuthTokenUserDefaultsKey: String = "authToken"
    static let LastLocationUserDefaultsKey: String = "lastLocation"
}

enum MockData {
    static let products: [ProductMockData] = [
        ProductMockData(
            name: "The Good Parts of AWS",
            creatorName: "Daniel Vassallo",
            imageUrlString: "https://static-2.gumroad.com/res/gumroad/5943448006997/asset_previews/52d22e2b611288ea3d787003fbcceaf9/retina/Cover-Gumroad.png",
            content: [
                ContentMockData(
                    name: "The Good Parts of AWS",
                    sizeKb: 345,
                    urlString: "https://github.com/nathanwchan/Gumroad2.0/raw/master/Mock%20Content/The%20Daily%20Stoic_%20366%20Meditations%20on%20Wisdom%2C%20Perseverance%2C%20and%20the%20Art%20of%20Living%20(%20PDFDrive.com%20).pdf"
                ),
                ContentMockData(
                    name: "The Good Parts of AWS",
                    sizeKb: 281,
                    urlString: "lkjsdf.epub"
                )
            ]
        ),
        ProductMockData(
            name: "Everyone Can Build a Twitter Audience",
            creatorName: "Daniel Vassallo",
            imageUrlString: "https://static-2.gumroad.com/res/gumroad/5943448006997/asset_previews/672387bf26c3ff0d4349e8f8ae18f171/retina/Cover.png",
            content: [
                ContentMockData(
                    name: "Intro",
                    sizeKb: 1200,
                    urlString: "lkjsdf.mp4"
                ),
                ContentMockData(
                    name: "Credibility",
                    sizeKb: 4200,
                    urlString: "lkjsdf.mp4"
                ),
                ContentMockData(
                    name: "Measure of Success",
                    sizeKb: 3100,
                    urlString: "lkjsdf.mp4"
                ),
                ContentMockData(
                    name: "Twitter Funnel",
                    sizeKb: 7200,
                    urlString: "lkjsdf.mp4"
                ),
                ContentMockData(
                    name: "What Not to Tweet",
                    sizeKb: 4800,
                    urlString: "lkjsdf.mp4"
                ),
                ContentMockData(
                    name: "What Not to Tweet Do",
                    sizeKb: 9000,
                    urlString: "lkjsdf.mp4"
                ),
                ContentMockData(
                    name: "Recap: Starter Strategy",
                    sizeKb: 4200,
                    urlString: "lkjsdf.mp4"
                ),
            ]
        ),
        ProductMockData(
            name: "Writing for Software Developers",
            creatorName: "Philip Kiely",
            imageUrlString: "https://philipkiely.com/assets/img/wfsd_paper_render.jpg",
            content: [
                ContentMockData(
                    name: "Writing for Software Developers",
                    sizeKb: 1345,
                    urlString: "https://github.com/nathanwchan/Gumroad2.0/raw/master/Mock%20Content/Dale_Carnegie_How_To_Stop_Worrying_And_Start_Living.pdf"
                )
            ]
        ),
        ProductMockData(
            name: "POST — A Short Story of No Consequence at All (PDF + AUDIOBOOK)",
            creatorName: "Shea Serrano",
            imageUrlString: "https://static-2.gumroad.com/res/gumroad/3015050709675/asset_previews/fbf4925553912ef3aba708c2a380056e/retina/POST_20_E2_80_94_20Cover.jpg",
            content: [
                ContentMockData(
                    name: "POST — A Short Story of No Consequence at All",
                    sizeKb: 132,
                    urlString: "lkjsdf.pdf"
                ),
                ContentMockData(
                    name: "POST — A Short Story of No Consequence at All",
                    sizeKb: 59832,
                    urlString: "https://github.com/nathanwchan/Gumroad2.0/raw/master/Mock%20Content/prince_00a_machiavelli.mp3"
                )
            ]
        ),
        ProductMockData(
            name: "CONFERENCE ROOM, FIVE MINUTES — Ten Illustrated Essays About The Office",
            creatorName: "Shea Serrano",
            imageUrlString: "https://static-2.gumroad.com/res/gumroad/3015050709675/asset_previews/dd472bffe57a0a49860bc926f01dd76f/retina/Screen_20Shot_202020-07-18_20at_2011.52.37_20AM.png",
            content: [
                ContentMockData(
                    name: "CONFERENCE ROOM, FIVE MINUTES — Ten Illustrated Essays About The Office",
                    sizeKb: 245,
                    urlString: "lkjsdf.pdf"
                )
            ]
        ),
        ProductMockData(
            name: "Hacking with iOS",
            creatorName: "Paul Hudson",
            imageUrlString: "https://static-2.gumroad.com/res/gumroad/1196435742118/asset_previews/2c720b37298ddfc4033f553f0ce6e105/retina/banner.png",
            content: [
                ContentMockData(
                    name: "Tutorials",
                    sizeKb: 1832,
                    urlString: "https://github.com/nathanwchan/Gumroad2.0/raw/master/Mock%20Content/swift_tutorial.pdf"
                ),
                ContentMockData(
                    name: "Sample code",
                    sizeKb: 159832,
                    urlString: "https://github.com/nathanwchan/Gumroad2.0/raw/master/Mock%20Content/swift_tutorial.zip"
                )
            ]
        ),
        ProductMockData(
            name: "SwiftUI by Example",
            creatorName: "Paul Hudson",
            imageUrlString: "https://static-2.gumroad.com/res/gumroad/1196435742118/asset_previews/c0c22993b6c0be58cf0827dd4e6aa168/retina/banner.png",
            content: [
                ContentMockData(
                    name: "Tutorials",
                    sizeKb: 2632,
                    urlString: "https://github.com/nathanwchan/Gumroad2.0/raw/master/Mock%20Content/swift_tutorial.pdf"
                ),
                ContentMockData(
                    name: "Sample code",
                    sizeKb: 109832,
                    urlString: "https://github.com/nathanwchan/Gumroad2.0/raw/master/Mock%20Content/swift_tutorial.zip"
                )
            ]
        ),
        ProductMockData(
            name: "Testing Swift",
            creatorName: "Paul Hudson",
            imageUrlString: "https://static-2.gumroad.com/res/gumroad/1196435742118/asset_previews/40d75ee7d79c7d92c0a4e1bc66c4b9dc/retina/banner.png",
            content: [
                ContentMockData(
                    name: "Tutorials",
                    sizeKb: 3232,
                    urlString: "https://github.com/nathanwchan/Gumroad2.0/raw/master/Mock%20Content/swift_tutorial.pdf"
                ),
                ContentMockData(
                    name: "Sample code",
                    sizeKb: 79832,
                    urlString: "https://github.com/nathanwchan/Gumroad2.0/raw/master/Mock%20Content/swift_tutorial.zip"
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
