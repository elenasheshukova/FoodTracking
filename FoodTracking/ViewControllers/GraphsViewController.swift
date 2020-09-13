//
//  GraphsViewController.swift
//  FoodTracking
//
//  Created by Елена Червоткина on 11.09.2020.
//  Copyright © 2020 noname. All rights reserved.
//

import UIKit

class GraphsViewController: UIViewController {
    
    @IBOutlet weak var circularProgress: CircularProgressView!
    
    var user: User!
    let foods = Food.getFoods()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circularProgress.trackClr = UIColor.systemGray
        circularProgress.progressClr = UIColor.systemGreen
        circularProgress.setProgressWithAnimation(duration: 1.0, value: 0.60)
    }
}
