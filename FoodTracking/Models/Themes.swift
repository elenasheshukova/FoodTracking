
//  Themes.swift
//  FoodTracking
//
//  Created by VICTOR on 13.09.2020.
//  Copyright © 2020 noname. All rights reserved.
//

import UIKit

struct AppTheme {
    var buttonBackgroundColor: UIColor
    var fieldBackgroundColor: UIColor
    var backgroundColor: UIColor
    var textColor: UIColor
    var switchColor: UIColor
}

extension AppTheme {
    static let light = AppTheme(
        buttonBackgroundColor: .green,
        fieldBackgroundColor: UIColor(white: 0.9, alpha: 1),
        backgroundColor: .white,
        textColor: .darkText,
        switchColor: .green

    )

    static let dark = AppTheme(
        buttonBackgroundColor: .lightText,
        fieldBackgroundColor: .lightGray,
        backgroundColor: .gray,
        textColor: .white,
        switchColor: UIColor(white: 0.4, alpha: 1)
    )
}
