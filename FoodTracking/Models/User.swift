//
//  User.swift
//  FoodTracking
//
//  Created by Елена Червоткина on 12.09.2020.
//  Copyright © 2020 noname. All rights reserved.
//

import Foundation

class User{
    
    static let shared = User()

    private init() {}
    
    var name: String = "Ivan"
    var weight: Float = 80
    
    var targetScores: Int = 20
    
    var dayScores : [DayScores] = [
        DayScores(date: Date(), scores: [(1, 6), (5, -2)])
    ]
}

class DayScores {
    var date : Date
    var scores: [(foodId: Int,  score: Int)]
    
    init(date: Date, scores: [(foodId: Int,  score: Int)]) {
        self.date   = date
        self.scores = scores
    }
}
