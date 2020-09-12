//
//  TabBarViewController.swift
//  FoodTracking
//
//  Created by Елена Червоткина on 12.09.2020.
//  Copyright © 2020 noname. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    let user = User.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers(with: user)
    }
    
    private func setupViewControllers(with user: User) {
        let trackingVC = viewControllers?[0] as! TrackingViewController
        let graphsVC = viewControllers?[1] as! GraphsViewController
        let profileVC = viewControllers?[2] as! ProfileViewController
        
        trackingVC.user = user
        graphsVC.user = user
        profileVC.user = user
    }
}
