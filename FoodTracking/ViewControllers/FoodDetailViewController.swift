//
//  FoodDetailViewController.swift
//  FoodTracking
//
//  Created by Елена Червоткина on 12.09.2020.
//  Copyright © 2020 noname. All rights reserved.
//

import UIKit

class FoodDetailViewController: UIViewController {
    
    var food: Food!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(food.name)
    }

}
