//
//  TabBarViewController.swift
//  FoodTracking
//
//  Created by Елена Червоткина on 12.09.2020.
//  Copyright © 2020 noname. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    var user = User.shared
    let foods = Food.getFoods()
    let userFirstLaunch  = """

        Алексей, добрый день!
        Мы сделали приложение, которое помогает правильно питаться. При этом оно основывается не на каллориях, а на качестве пищи, которую мы потребляем каждый день.
        
        Начать им пользоваться достаточно просто - зайди на первый экран, и ты увидишь, что продукты разделены на полезные и вредные. Про то, что входит в каждую категорию продуктов можно узнать провалившись в описание категории. Добавляй баллы за каждую порцию полезных продуктов или вычитай их из дневного бюджета потребляя вредные. Дневная цель - набрать 80% от максимально возможного количества баллов.
        На втором экране тебя ждёт круговая диаграмма дневных достижений; сумма полезных баллов, на которую ещё можно рассчитывать сегодня.
        На третьем экране тебя ожидает экран профиля пользователя с расчётом Индекса Массы Тела, выбора системы измерений, установкой цветовой темы приложения.

        Если впереди нас будет ожидать ещё одна командная работа, мы будем рады доработать данное приложение, добавив загрузку/выгрузку на сервер, создание личного кабинета и графика достижений за неделю/месяц/год.

        """
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers(with: user)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !appDelegate.hasAlreadyLaunched {
            appDelegate.sethasAlreadyLaunched()
            displayLicenAgreement(message: self.userFirstLaunch)
        }
    }
    
    func displayLicenAgreement(message:String){
        let alert = UIAlertController(title: "О чём наше приложение?", message: message, preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "Покажите его скорее!", style: .default)
        
        alert.addAction(acceptAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setupViewControllers(with user: User) {
        let trackingVC = viewControllers?[0] as! TrackingViewController
        let graphsVC = viewControllers?[1] as! GraphsViewController
        let profileVC = viewControllers?[2] as! ProfileViewController
        
        trackingVC.user = user
        trackingVC.foods = foods
        graphsVC.user = user
        graphsVC.foods = foods
        profileVC.user = user
    }
}
