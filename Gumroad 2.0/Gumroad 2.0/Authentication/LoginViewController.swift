//
//  LoginViewController.swift
//  Gumroad 2.0
//
//  Created by Nathan Chan on 9/7/20.
//

import UIKit

class LoginViewController: UIViewController, StoryboardIdentifiable {
    static var storyboardName: StoryboardName = .authentication

    @IBAction func loginClicked(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: Globals.AuthTokenUserDefaultsKey)
        dismiss(animated: true, completion: nil)
    }
}

