//
//  TrackingViewController.swift
//  FoodTracking
//
//  Created by Елена Червоткина on 11.09.2020.
//  Copyright © 2020 noname. All rights reserved.
//

import UIKit

class TrackingViewController: UIViewController {

    @IBOutlet weak var dailyScoresTableView: UITableView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nextDateButton: UIButton!
    @IBOutlet weak var prevDateButton: UIButton!
    
    var user: User!
    var foods: [Food]!
    var date = Date().stripTime()
    
    var currentDayScores: [(foodId: Int, score: Int)] {
        if let currentDayScores = user.dayScores[date] {
            return currentDayScores
        } else {
            return []
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: date)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        dateLabel.text = formatter.string(from: date)
        
        let total = user.getTotalScore(date: date)
        print(total)

        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? FoodDetailViewController else { return }
        guard let indexPath = dailyScoresTableView.indexPathForSelectedRow else { return }
        detailVC.food = foods.filter{$0.type == FoodQualityType.allCases[indexPath.section]}[indexPath.row]
    }
}

extension TrackingViewController: UITableViewDataSource{
    
    //количество секций в таблице
    func numberOfSections(in tableView: UITableView) -> Int {
        return FoodQualityType.allCases.count
    }
    
    //заголовок секции
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return FoodQualityType.allCases[section].rawValue
    }
    
    //количество строк в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.filter{$0.type == FoodQualityType.allCases[section]}.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "food", for: indexPath) as! FoodTableViewCell
        let food = foods.filter{$0.type == FoodQualityType.allCases[indexPath.section]}[indexPath.row]
        cell.nameLabel.text = food.name
        
        let score = currentDayScores.filter( {$0.foodId == food.id} ).first?.score ?? 0
        
        for index in cell.scoreButtons.indices{
            if index < food.scores.count{
                
                let button = cell.scoreButtons[index]
                button.setTitle(String(food.scores[index]), for: UIControl.State.normal)
                
                button.backgroundColor = index < score ? .yellow : .white
            }
        }
        cell.tag = food.id
        cell.cellDelegate = self
        return cell
    }
}

extension TrackingViewController: FoodTableViewCellDelegate {
    func customcell(cell: FoodTableViewCell, didTappedThe button: UIButton?) {
        if button?.backgroundColor == .yellow {
            user.deleteScore(date: date, foodId: cell.tag)
        } else {
            user.addScore(date: date, foodId: cell.tag)
        }
        dailyScoresTableView.reloadData()
        print(user.getTotalScore(date: date))
    }
}
