//
//  Food.swift
//  FoodTracking
//
//  Created by Елена Червоткина on 12.09.2020.
//  Copyright © 2020 noname. All rights reserved.
//

import Foundation

enum FoodQualityType: String, CaseIterable{
    case high = "High quality foods"
    case low = "Low quality foods"
}

struct Food{
    var name: String
    var type: FoodQualityType
    var scores: [Int]
    var text: String
}

extension Food {
    static func getFoods() -> [Food] {
        return [
            Food(
                name: "Vegetables",
                type: .high,
                scores: [2, 2, 2, 1, 0, 0],
                text: ""
            ),
            Food(
                name: "Fruit",
                type: .high,
                scores: [2, 2, 2, 1, 0, 0],
                text: ""
            ),
            Food(
                name: "Nuts, Seeds and Healthy Oils",
                type: .high,
                scores: [2, 2, 1, 0, 0, -1],
                text: ""
            ),
            //...
            Food(
                name: "Refined Grains",
                type: .low,
                scores: [-1, -1, -2, -2, -2, -2],
                text: ""
            ),
            Food(
                name: "Sweets",
                type: .low,
                scores: [-2, -2, -2, -2, -2, -2],
                text: ""
            ),
            Food(
                name: "Processed Meat",
                type: .low,
                scores: [-2, -2, -2, -2, -2, -2],
                text: ""
            ),
            //...
        ]
    }
}
