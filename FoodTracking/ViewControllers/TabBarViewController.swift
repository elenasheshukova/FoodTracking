//
//  TabBarViewController.swift
//  FoodTracking
//
//  Created by Елена Червоткина on 12.09.2020.
//  Copyright © 2020 noname. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    var user = User.shared
    let foods = Food.getFoods()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers(with: user)
    }
    
    private func setupViewControllers(with user: User) {
        let trackingVC = viewControllers?[0] as! TrackingViewController
        let graphsVC = viewControllers?[1] as! GraphsViewController
        let profileVC = viewControllers?[2] as! ProfileViewController
        
        trackingVC.user = user
        trackingVC.foods = foods
        graphsVC.user = user
        graphsVC.foods = foods
        profileVC.user = user
    }
}
