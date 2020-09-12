//
//  CreatorFilterButton.swift
//  Gumroad 2.0
//
//  Created by Nathan Chan on 9/12/20.
//

import UIKit

class CreatorFilterButton: UIButton {
    let creatorName: String
    let type: CreatorFilterButtonType

    required init(creatorName: String, type: CreatorFilterButtonType) {
        self.creatorName = creatorName
        self.type = type

        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static let emptyUIImage = UIImage(named: "checkbox-empty.png")
    static let filledUIImage = UIImage(named: "checkbox-filled.png")
}

enum CreatorFilterButtonType {
    case all
    case creator
    case archived
}
