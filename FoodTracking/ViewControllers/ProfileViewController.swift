//
//  ProfileViewController.swift
//  FoodTracking
//
//  Created by Елена Червоткина on 11.09.2020.
//  Copyright © 2020 noname. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var generalTextLabel: UILabel!
    @IBOutlet weak var resultOfTodayLabel: UILabel!
    
    @IBOutlet weak var generaIMTLabel: UILabel!
    @IBOutlet weak var heightInputField: UITextField!
    @IBOutlet weak var heightInputLabel: UILabel!
    @IBOutlet weak var weightInputField: UITextField!
    @IBOutlet weak var weightInputLabel: UILabel!
    @IBOutlet weak var userIMTLabel: UILabel!
    @IBOutlet weak var calculatedIMTLabel: UILabel!
    @IBOutlet weak var recommendedIMTLabel: UILabel!
    @IBOutlet weak var englDimensionLabel: UILabel!
    @IBOutlet weak var metricDimensionLabel: UILabel!
    @IBOutlet weak var metricSwitch: UISwitch!
    @IBOutlet weak var currentImtState: UILabel!
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var colorThemeButton: UIButton!
    @IBOutlet weak var colorThemeLabel: UILabel!
    
    var user: User!
    let date = Date().stripTime()
    
    
    private let light = AppTheme.light
    private let dark = AppTheme.dark
    
    private var height = 180.0
    private var weight = 80.0
    
    private enum periodOfDay: String {
        case morning, day, evening, night
        var label: String {
            switch self {
            case .morning: return "Good morning"
            case .day: return "Good day"
            case .evening: return "Good evening"
            case .night: return "Good night"
            }
        }
    }
    private var period : periodOfDay = .day
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // показ текущего времени и таймер обновления его
        showCurrentTime()
        _ = Timer.scheduledTimer(timeInterval: 60, target: self,selector: #selector(showCurrentTime), userInfo: nil, repeats: true)
        // отображение текстовых полей
        textMessages()
        // добавление кнопки Done в клавиатуру
        addDoneButton()
        // настройка переключателя
        metricSwitch.isOn = true
        metricSwitch.backgroundColor = .green
        metricSwitch.layer.cornerRadius = metricSwitch.bounds.height / 2
        
       
    }
    // смена темы день-ночь
    @IBAction func changeThemeButton() {
        view.backgroundColor == dark.backgroundColor ? applyTheme(light) : applyTheme(dark)
    }
    // настройка полей ввода данных и пересчет итога
    @IBAction func heightInputAction(_ sender: Any) {
        height = Double(heightInputField.text!) ?? 0
        calculateIMT()
    }
    @IBAction func weightInputAction(_ sender: Any) {
        weight = Double(weightInputField.text!) ?? 0
        calculateIMT()
    }
    @IBAction func dimentionChangedSwitch() {
        englDimensionLabel.alpha = metricSwitch.isOn ? 0.2 : 1
        metricDimensionLabel.alpha = metricSwitch.isOn ? 1 : 0.2
        
        if metricSwitch.isOn {
            height /= 0.3937
            weight /= 2.2046
        } else {
            height *= 0.3937
            weight *= 2.2046
        }
        heightInputField.text = String(format: "%.00f",height)
        weightInputField.text = String(format: "%.00f",weight)
        calculateIMT()
    }
    // функция расчета и вывода Индекса массы тела
    private func calculateIMT() {
        var imt = weight / ((height/100) * (height / 100))
        imt = metricSwitch.isOn ? imt : imt*703/10000
        
        calculatedIMTLabel.text = String(format: "%.02f", imt)
        recommendedIMTLabel.text = "Recommended BWI is 18-25. Your BWI is \(calculatedIMTLabel.text ?? "not yet calculated. Please input correct weight & height.")"
        var message : String? {
            switch imt {
            case 0..<16 : return "Strong deficit of body weight"
            case 16..<18 : return "Insufficient body weight"
            case 18..<25 : return "Normal weight"
            case 25..<30 : return "Excess body weight"
            case 30... : return "Obesity"
            default: return nil
            }
        }
        currentImtState.text = "Your current state: \(message ?? "not yet defined. Please enter weight & height.")"
    }
    // вывод результатов с предыд. экрана таббара
    private func textMessages() {
        greetingLabel.text = "\(period.label) , \(user.name)! "
        resultOfTodayLabel.text = "Your current result: \(user.getTotalScore(date: date))"
        
    }
    // функция смены темы экрана
    private func applyTheme(_ theme: AppTheme) {
        view.backgroundColor = theme.backgroundColor
        greetingLabel.textColor = theme.textColor
        resultOfTodayLabel.textColor = theme.textColor
        heightInputField.backgroundColor = theme.fieldBackgroundColor
        weightInputField.backgroundColor = theme.fieldBackgroundColor
        calculatedIMTLabel.textColor = theme.textColor
        recommendedIMTLabel.textColor = theme.textColor
        englDimensionLabel.textColor = theme.textColor
        metricDimensionLabel.textColor = theme.textColor
        currentTimeLabel.textColor = theme.textColor
        colorThemeButton.backgroundColor = theme.buttonBackgroundColor
        colorThemeButton.tintColor = theme.textColor
        metricSwitch.backgroundColor = theme.switchColor
        metricSwitch.onTintColor = theme.switchColor
        currentImtState.textColor = theme.textColor
        heightInputLabel.textColor = theme.textColor
        weightInputLabel.textColor = theme.textColor
        userIMTLabel.textColor = theme.textColor
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
        let minutes = calendar.component(.minute, from: date)
        currentTimeLabel.text = "Current time: \(hour) : \(minutes)"
        
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


