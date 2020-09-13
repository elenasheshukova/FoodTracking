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
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var user: User!
    let foods = Food.getFoods()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeView(day: 7)
        //changeView(day: user.dayScores.count)
    }
}

extension GraphsViewController {
    private func changeView(day score: Int) {
        
        switch score {
        case 0..<7:
            circularProgress.trackClr = UIColor.systemGray
            circularProgress.progressClr = UIColor.systemYellow
            circularProgress.setProgressWithAnimation(duration: 4.0,
                                                      value: Float(score))
            view.backgroundColor = .clear
            descriptionLabel.text = "Отличное начало! 👏🏻"
        case 7..<15:
            circularProgress.trackClr = UIColor.systemGray
            circularProgress.progressClr = UIColor.systemGreen
            circularProgress.setProgressWithAnimation(duration: 4.0,
                                                  value: Float(score))
            view.backgroundColor = .systemYellow
            descriptionLabel.text = "Ты почти у цели 🔥"
        case 15:
            circularProgress.trackClr = UIColor.systemGray
            circularProgress.progressClr = UIColor.systemGreen
            circularProgress.setProgressWithAnimation(duration: 4.0,
                                                  value: Float(score))
            view.backgroundColor = .systemYellow
            descriptionLabel.text = "Ты достиг дневной цели! Молодец! 🤟🏻"
        case 16..<19:
            circularProgress.trackClr = UIColor.systemGray
            circularProgress.progressClr = UIColor.systemGreen
            circularProgress.setProgressWithAnimation(duration: 4.0,
                                                  value: Float(score))
            view.backgroundColor = .systemYellow
            descriptionLabel.text = "Да ты удивляешь 😉"
        case 19:
            circularProgress.trackClr = UIColor.systemGray
            circularProgress.progressClr = UIColor.systemGreen
            circularProgress.setProgressWithAnimation(duration: 4.0,
                                                      value: Float(score))
            view.backgroundColor = .systemYellow
            descriptionLabel.text = "Вот это день! Продолжай в том же духе 🥳"
        default:
            circularProgress.trackClr = UIColor.systemGray
            circularProgress.progressClr = UIColor.systemGreen
            circularProgress.setProgressWithAnimation(duration: 4.0,
                                                      value: Float(score))
        }
    }
}
