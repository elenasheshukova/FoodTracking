//
//  FoodDetailViewController.swift
//  FoodTracking
//
//  Created by Елена Червоткина on 12.09.2020.
//  Copyright © 2020 noname. All rights reserved.
//

import UIKit

class FoodDetailViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    var food: Food!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = food.name
        textLabel.text = food.text
    }
}
