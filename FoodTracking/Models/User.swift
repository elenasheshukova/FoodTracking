//
//  User.swift
//  FoodTracking
//
//  Created by Елена Червоткина on 12.09.2020.
//  Copyright © 2020 noname. All rights reserved.
//

import Foundation

class User{
    var name: String?
    var weight: Float?
    
    var targetScores: Int?
    
    var dayScores : [DayScores]?
    
    init() {
        self.name = "Ivan"
        self.weight = 80
        self.targetScores = 20
        self.dayScores = [
            DayScores(date: Date(), scores: [(1, 6), (5, -2)])
        ]
    }
}

class DayScores {
    var date : Date
    var scores: [(foodId: Int,  score: Int)]
    
    init(date: Date, scores: [(foodId: Int,  score: Int)]) {
        self.date   = date
        self.scores = scores
    }
}
