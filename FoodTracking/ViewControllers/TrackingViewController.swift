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
    
    let foods = Food.getFoods()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? FoodDetailViewController else { return }
        guard let indexPath = dailyScoresTableView.indexPathForSelectedRow else { return }
        detailVC.food = foods[indexPath.row]
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
        cell.nameLabel.text = foods.filter{$0.type == FoodQualityType.allCases[indexPath.section]}[indexPath.row].name
        return cell
    }
}
