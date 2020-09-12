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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "food", for: indexPath) as! FoodTableViewCell
        cell.nameLabel.text = foods[indexPath.row].name
        
        return cell
    }
}
