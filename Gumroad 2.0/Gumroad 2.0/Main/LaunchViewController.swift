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

        let vc = AuthenticationViewController.instantiate()
        let navVC = UINavigationController(rootViewController: vc)

//        let vc = MainMenuViewController.instantiate()
//        let navVC = MainActivityNavigationController(rootViewController: vc)

        navVC.modalPresentationStyle = .fullScreen
        navVC.setNavigationBarHidden(true, animated: false)
        present(navVC, animated: true, completion: nil)
    }
}
