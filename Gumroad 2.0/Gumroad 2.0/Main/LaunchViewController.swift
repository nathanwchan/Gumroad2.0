//
//  LaunchViewController.swift
//  Gumroad 2.0
//
//  Created by Nathan Chan on 9/5/20.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let vc: UIViewController
        if UserDefaults.standard.bool(forKey: Globals.AuthTokenUserDefaultsKey) {
            let tabVC = UITabBarController()
            let firstVC = LibraryViewController.instantiate()
            firstVC.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "book.fill"), tag: 0)
            tabVC.viewControllers = [firstVC]
            vc = tabVC
        } else {
            vc = AuthenticationViewController.instantiate()
        }
        let navVC = UINavigationController(rootViewController: vc)

        navVC.modalPresentationStyle = .fullScreen
        navVC.setNavigationBarHidden(true, animated: false)
        present(navVC, animated: true, completion: nil)
    }
}
