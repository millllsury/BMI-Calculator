//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Ekaterina Bastrikina on 02/02/2026.
//

import UIKit

class MainViewController: UIViewController {
    
    private let mainView = MainView()
    
    private lazy var maleButton = mainView.maleButton
    private lazy var femaleButton = mainView.femaleButton
    private lazy var calculateButton = mainView.calculateButton
    
    private lazy var heightMeasure = mainView.heightMeasure
    private lazy var heightSlider = mainView.heightSlider
    
    private var heightMeasureConverted: Int {
        Int(heightSlider.value)
    }
    
    private lazy var plusWeightButton = mainView.plusWeightButton
    private lazy var minusWeightButton = mainView.minusWeightButton
    
    private lazy var plusAgeButton = mainView.plusAgeButton
    private lazy var minusAgeButton = mainView.minusAgeButton
    
    private lazy var weightValue = mainView.weightValue
    private lazy var ageValue = mainView.ageValue
    
    override func loadView() {
        view = mainView
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "BMI Calculator"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        heightMeasure.text = String(heightMeasureConverted)
        weightValue.text = "50"
        ageValue.text = "25"
        setupActions()
    }
    
    
    // MARK: Actions
    private func setupActions() {
        maleButton.addTarget(self, action: #selector(toggleGenderButton), for: .touchUpInside)
        maleButton.isSelected = true
        
        femaleButton.addTarget(self, action: #selector(toggleGenderButton), for: .touchUpInside)
        calculateButton.addTarget(self, action: #selector(calculateButtonTap), for: .touchUpInside)
        
        heightSlider.addTarget(self, action: #selector(useSlider) , for: .valueChanged)
        
        plusAgeButton.addTarget(self, action: #selector(agePlusButtonPressed), for: .touchUpInside)
        minusAgeButton.addTarget(self, action: #selector(ageMinusButtonPressed), for: .touchUpInside)
        
        plusWeightButton.addTarget(self, action: #selector(weightPlusButtonPressed), for: .touchUpInside)
        minusWeightButton.addTarget(self, action: #selector(weightMinusButtonPressed), for: .touchUpInside)
        
    }
    
    private func circleButtonPressed(label: UILabel, sign: String) {
        
        var value = Int(label.text ?? "0")!
        
        switch sign {
        case "+":
            value += 1
        case "-":
            if value <= 0 { return }
            value -= 1
        default:
            break
        }
        
        label.text = String(value)
    }
    
    @objc private func agePlusButtonPressed() {
        circleButtonPressed(label: ageValue, sign: "+")
    }
    
    @objc private func ageMinusButtonPressed() {
        circleButtonPressed(label: ageValue, sign: "-")
    }
    
    @objc private func weightPlusButtonPressed() {
        circleButtonPressed(label: weightValue, sign: "+")
    }
    
    @objc private func weightMinusButtonPressed() {
        circleButtonPressed(label: weightValue, sign: "-")
    }
    
    @objc private func useSlider() {
        heightMeasure.text = String(heightMeasureConverted)
    }
    
    @objc private func toggleGenderButton(sender: UIButton) {
        maleButton.isSelected = (sender == maleButton)
        femaleButton.isSelected = (sender == femaleButton)
    }
    
    @objc private func calculateButtonTap() {
        let genderIndex = maleButton.isSelected ? 0 : 1
        let gender: Gender = Gender(rawValue: genderIndex)!
        let height = heightMeasureConverted
        let weight = Int(weightValue.text!)!
        let age = Int(ageValue.text!)!
        
        let bmi = BMI(gender: gender, height: height, weight: weight, age: age)
        print(bmi)
        let resultVC = ResultViewController(bmi: bmi)
        navigationController?.pushViewController(resultVC, animated: true)

    }
    

}


