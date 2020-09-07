//
//  MainViewController.swift
//  Gumroad 2.0
//
//  Created by Nathan Chan on 9/7/20.
//

import UIKit

class MainViewController: UIViewController, StoryboardIdentifiable {
    static var storyboardName: StoryboardName = .main

    @IBAction func logoutClicked(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: Globals.AuthTokenUserDefaultsKey)
        dismiss(animated: true, completion: nil)
    }
}
