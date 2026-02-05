//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Ekaterina Bastrikina on 02/02/2026.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: UI
    
    let bgColor = UIColor(r: 21, g: 23, b: 40, a: 1)
    let secondaryColor = UIColor(r: 100, g: 104, b: 193, a: 0.8)
    let stackColor = UIColor(r: 30, g: 32, b: 56, a: 1)
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            genderButtonsStack,
            sliderStack,
            weightAgeStack
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 24
        stack.distribution = .fill
        return stack
    }()
    
    // MARK: UI - Gender Buttons
    private lazy var maleButton = makeGenderButton(systemName: "figure.stand", title: "Male")
    private lazy var femaleButton = makeGenderButton(systemName: "figure.stand.dress", title: "Female")
    
    private lazy var genderButtonsStack = makeButtonsStack(firstButton: maleButton, secondButton: femaleButton, spacing: 16)    
   
    // MARK: UI - Height Slider Section
    private lazy var heightLabel = makeLabel(text: "Height")
    private lazy var heightMeasure = labelValue()
    private lazy var cmLabel = makeLabel(text: "cm")

    
    private lazy var sliderStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            heightLabel, heightCMStack, heightSlider
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.backgroundColor = stackColor
        stack.layer.cornerRadius = 10
        stack.spacing = 16
        stack.alignment = .center
        return stack
    }()
    
    private lazy var heightSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 250
        slider.value = 150
        slider.maximumTrackTintColor = secondaryColor
        slider.minimumTrackTintColor = .systemPink
        slider.thumbTintColor = .systemPink
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private lazy var heightCMStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            heightMeasure,cmLabel
        ])
        stack.axis = .horizontal
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .bottom
        return stack
    }()
    
    // MARK: UI - Weight and Age Section
    
    private lazy var weightAgeStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            weightStack, ageStack
        ])
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var weightLabel = makeLabel(text: "Weight")
    private lazy var ageLabel = makeLabel(text: "Age")
    
    private lazy var plusWeightButton = circleButton(systemName: "plus.circle.fill")
    private lazy var minusWeightButton = circleButton(systemName: "minus.circle.fill")
    
    private lazy var plusAgeButton = circleButton(systemName: "plus.circle.fill")
    private lazy var minusAgeButton = circleButton(systemName: "minus.circle.fill")
    
    private lazy var weightButtonsStack = makeButtonsStack(firstButton: plusWeightButton, secondButton: minusWeightButton, spacing: 8)
    private lazy var ageButtonsStack = makeButtonsStack(firstButton: plusAgeButton, secondButton: minusAgeButton, spacing: 8)
    
    private lazy var weightStack = makeWeightAgeStack(titleLabel: weightLabel, valueLabel: weightValue, stack: weightButtonsStack)
    private lazy var ageStack = makeWeightAgeStack(titleLabel: ageLabel, valueLabel: ageValue, stack: ageButtonsStack)
    
    private lazy var weightValue = labelValue()
    private lazy var ageValue = labelValue()
    
    private func labelValue() -> UILabel {
        let label = UILabel()
        label.text = "10"
        label.font = .boldSystemFont(ofSize: 60)
        label.textColor = .white
        return label
    }

    private func circleButton(systemName: String) -> UIButton {
        let symbolConfig = UIImage.SymbolConfiguration(
            pointSize: 44,
            weight: .medium
        )
//        .applying(UIImage.SymbolConfiguration(
//            paletteColors: [ .white, secondaryColor]
//        ))
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: systemName, withConfiguration: symbolConfig)
        config.baseForegroundColor = secondaryColor
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }
    
    private func makeWeightAgeStack(titleLabel: UILabel, valueLabel: UILabel, stack: UIStackView) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [
            titleLabel, valueLabel, stack
        ])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.layer.cornerRadius = 10
        stack.backgroundColor = stackColor
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20) //
        stack.isLayoutMarginsRelativeArrangement = true //
        return stack
    }
    
    // MARK: UI - Calculate Button
    
    private lazy var calculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Calculate", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemPink
        return button
    }()
        
    // MARK: UI - Common Functions
    
    private func makeGenderButton(systemName: String, title: String) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: systemName, withConfiguration: UIImage.SymbolConfiguration(pointSize: 64, weight: .bold))
        config.title = title
        config.baseForegroundColor = .white   // цвет иконки
        config.titleAlignment = .center
        config.background.cornerRadius = 10
        config.imagePlacement = .top
        config.imagePadding = 32
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configurationUpdateHandler = { button in
            var config = button.configuration
            if button.isSelected {
                config?.background.backgroundColor = self.secondaryColor
            } else {
                config?.background.backgroundColor = self.stackColor
            }
            button.configuration = config
        }
        return button
    }
    
    private func makeLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }
    
    private func makeButtonsStack(firstButton: UIButton, secondButton: UIButton, spacing: CGFloat) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [
            firstButton, secondButton
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = spacing
        stack.distribution = .fillEqually
        return stack
    }

    // MARK: Setup Appearance
    
    private func setupHierarchy() {
        view.addSubview(mainStack)
        view.addSubview(calculateButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: calculateButton.topAnchor, constant: -16),
            mainStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            genderButtonsStack.topAnchor.constraint(equalTo: mainStack.topAnchor),
            genderButtonsStack.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
            genderButtonsStack.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
            genderButtonsStack.bottomAnchor.constraint(equalTo: maleButton.bottomAnchor),
            
            sliderStack.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
            sliderStack.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
            
            genderButtonsStack.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            heightSlider.widthAnchor.constraint(equalTo: sliderStack.widthAnchor, multiplier: 0.8),
            
            calculateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            calculateButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),
            calculateButton.widthAnchor.constraint(equalTo: view.widthAnchor)
            
        ])
    }
    
    private func setupAppearance() {
        maleButton.tag = 1
        femaleButton.tag = 2
    }
    
    private func bindData() {
        heightMeasure.text = "171"
    }
    
    private func setupActions() {
        maleButton.isSelected = true
        femaleButton.isSelected = false
        maleButton.addTarget(nil, action: #selector(toggleGenderButton), for: .touchUpInside)
        femaleButton.addTarget(nil, action: #selector(toggleGenderButton), for: .touchUpInside)
    }
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "BMI Calculator"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        view.backgroundColor = bgColor
        setupHierarchy()
        setupLayout()
        setupAppearance()
        bindData()
        setupActions()
    }
    
    
    // MARK: Actions
    
    @objc private func toggleGenderButton(sender: UIButton) {
        maleButton.isSelected = sender == maleButton
        femaleButton.isSelected = sender == femaleButton
    }

}


