//
//  ProfileViewController.swift
//  FoodTracking
//
//  Created by Елена Червоткина on 11.09.2020.
//  Copyright © 2020 noname. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var textLabels: [UILabel]!
    
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var resultOfTodayLabel: UILabel!
    @IBOutlet weak var heightInputField: UITextField!
    @IBOutlet weak var weightInputField: UITextField!
    @IBOutlet weak var calculatedIMTLabel: UILabel!
    @IBOutlet weak var recommendedIMTLabel: UILabel!
    @IBOutlet weak var englDimensionLabel: UILabel!
    @IBOutlet weak var metricDimensionLabel: UILabel!
    @IBOutlet weak var metricSwitch: UISwitch!
    @IBOutlet weak var currentImtState: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var colorThemeButton: UIButton!
    
    var user: User!
    let date = Date().stripTime()
    
    private let light = AppTheme.light
    private let dark = AppTheme.dark
    
    private enum periodOfDay: String {
        case morning, day, evening, night
        var label: String {
            switch self {
            case .morning: return "Доброе утро"
            case .day: return "Добрый день"
            case .evening: return "Добрый вечер"
            case .night: return "Доброй ночи"
            }
        }
    }
    private var period : periodOfDay = .day
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // показ текущего времени и таймер обновления его
        showCurrentTime()
        _ = Timer.scheduledTimer(timeInterval: 60, target: self,selector: #selector(showCurrentTime), userInfo: nil, repeats: true)
        
        textMessages()
        addDoneButton()
        metricSwitch.backgroundColor = .green
        metricSwitch.layer.cornerRadius = metricSwitch.bounds.height / 2
    }
    // смена темы день/ночь
    @IBAction func changeThemeButton() {
        view.backgroundColor == dark.backgroundColor ? applyTheme(light) : applyTheme(dark)
    }
    // настройка полей ввода данных и пересчет итога
    @IBAction func heightInputAction(_ sender: Any) {
        user.height = Double(heightInputField.text!) ?? 0
        calculateIMT()
    }
    @IBAction func weightInputAction(_ sender: Any) {
        user.weight = Double(weightInputField.text!) ?? 0
        calculateIMT()
    }
    @IBAction func dimentionChangedSwitch() {
        englDimensionLabel.alpha = metricSwitch.isOn ? 0.2 : 1
        metricDimensionLabel.alpha = metricSwitch.isOn ? 1 : 0.2
        
        if metricSwitch.isOn {
            user.height /= 0.3937
            user.weight /= 2.2046
        } else {
            user.height *= 0.3937
            user.weight *= 2.2046
        }
        heightInputField.text = String(format: "%.00f",user.height)
        weightInputField.text = String(format: "%.00f",user.weight)
        calculateIMT()
    }
    // функция расчета и вывода Индекса массы тела
    private func calculateIMT() {
        var imt = user.weight / ((user.height/100) * (user.height / 100))
        imt = metricSwitch.isOn ? imt : imt*703/10000
        
        calculatedIMTLabel.text = String(format: "%.02f", imt)
        recommendedIMTLabel.text = "Рекомендуемый ИМТ 18-25. Твой ИМТ \(calculatedIMTLabel.text ?? "ещё не рассчитан. Пожалуйста, введи правильный вес и рост.")"
        var message : String? {
            switch imt {
            case 0..<16 : return "Сильный дефицит массы тела"
            case 16..<18 : return "Недостаточная масса тела"
            case 18..<25 : return "Нормальный вес"
            case 25..<30 : return "Избыточная масса тела"
            case 30... : return "Ожирение"
            default: return nil
            }
        }
        currentImtState.text = "Текущее состояние: \(message ?? "ещё не определено. Пожалуйста, введи вес и рост.")"
    }
    // вывод результатов с предыд. экрана таббара
    private func textMessages() {
        greetingLabel.text = "\(period.label), \(user.name)! "
        resultOfTodayLabel.text = "Твой текущий результат: \(user.getTotalScore(date: date))"
    }
    // функция смены темы экрана
    private func applyTheme(_ theme: AppTheme) {
        user.colorTheme = theme
        view.backgroundColor = theme.backgroundColor
        textLabels.forEach { text in
            text.textColor = theme.textColor
        }
        heightInputField.backgroundColor = theme.fieldBackgroundColor
        weightInputField.backgroundColor = theme.fieldBackgroundColor
        colorThemeButton.backgroundColor = theme.buttonBackgroundColor
        colorThemeButton.tintColor = theme.textColor
        metricSwitch.backgroundColor = theme.switchColor
        metricSwitch.onTintColor = theme.switchColor
    }
    //  функция добавления кнопки done в клавиатуру
    private func addDoneButton() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneButtonAction))
        ]
        heightInputField.inputAccessoryView = toolBar
        weightInputField.inputAccessoryView = toolBar
    }
    @objc func doneButtonAction() {
        view.endEditing(true)
    }
    
    // функция вывода текущего времени
    @objc private func showCurrentTime() {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let stringHour = hour < 10 ? "0\(hour)" : String(hour)
        let minutes = calendar.component(.minute, from: date)
        let stringMinutes = minutes < 10 ? "0\(minutes)" : String(minutes)
        currentTimeLabel.text = "Текущее время: " + stringHour + ":" + stringMinutes
        
        switch hour {
        case 8...11: period = periodOfDay.morning
        case 12...17: period = periodOfDay.day
        case 18...21: period = periodOfDay.evening
        default: period = periodOfDay.night
        }
    }
}

extension ProfileViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == heightInputField {
            textField.resignFirstResponder()
            weightInputField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
