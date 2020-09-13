//
//  FoodTableViewCell.swift
//  FoodTracking
//
//  Created by Елена Червоткина on 12.09.2020.
//  Copyright © 2020 noname. All rights reserved.
//

import UIKit

protocol FoodTableViewCellDelegate : class {
    func customcell(cell : FoodTableViewCell, didTappedThe button : UIButton?)
}

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var scoreButtons: [UIButton]!
    
    weak var cellDelegate : FoodTableViewCellDelegate?

    @IBAction func changeScores(_ sender: UIButton) {
        cellDelegate?.customcell(cell: self, didTappedThe: sender)
    }
}
