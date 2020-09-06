//
//  StoryboardIdentifiable.swift
//  Gumroad 2.0
//
//  Created by Nathan Chan on 9/5/20.
//

import UIKit

enum StoryboardName: String {
    case main
    case authentication
    // these string values get capitalized for storyboard file lookup
}

protocol StoryboardIdentifiable where Self: UIViewController {
    static var storyboardName: StoryboardName { get }
}

extension StoryboardIdentifiable {
    static func storyboardIdentifier() -> String {
        return String(describing: Self.self)
    }

    static func storyboard() -> UIStoryboard {
        return UIStoryboard(name: Self.storyboardName.rawValue.capitalizingFirstLetter(), bundle: nil)
    }

    static func instantiate() -> Self {
        return storyboard().instantiateViewController(withIdentifier: Self.storyboardIdentifier()) as! Self
    }
}

