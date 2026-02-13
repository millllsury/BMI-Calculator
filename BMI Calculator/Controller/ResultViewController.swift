//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Ekaterina Bastrikina on 12/02/2026.
//

import UIKit

class ResultViewController: UIViewController {

    // MARK: UI
    private lazy var yourResultLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Result"
        label.font = .boldSystemFont(ofSize: 40)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            statusLabel, valueLabel, descriptionOfResult
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.backgroundColor = .stack
        stack.layer.cornerRadius = 10
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        return stack
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .medium)
        label.textColor = .green
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 64, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionOfResult: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var recalculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Re-Calculate", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemPink
        return button
    }()
    
    // MARK: Init
    var bmi: BMI
    
    init(bmi: BMI) {
        self.bmi = bmi
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        title = "BMI Calculator"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        setupHierarchy()
        setupLayout()
        getData()
        setupActions()
    }
    
    // MARK: Setup Appearance
    private func setupHierarchy() {
        view.addSubview(yourResultLabel)
        view.addSubview(stack)
        view.addSubview(recalculateButton)
        
        yourResultLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        recalculateButton.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            yourResultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            yourResultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            yourResultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            stack.topAnchor.constraint(equalTo: yourResultLabel.bottomAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: recalculateButton.topAnchor, constant: -16),

            recalculateButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 16),
            recalculateButton.widthAnchor.constraint(equalTo: view.widthAnchor),
            recalculateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            recalculateButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),
        ])
    }
    
    // MARK: Get Data
    private func getData() {
        statusLabel.text = bmi.result().statusName
        statusLabel.textColor = bmi.result().uiColor
        valueLabel.text = String(format: "%.1f", bmi.calculatedBMI)
        descriptionOfResult.text = bmi.result().description
    }
    
    // MARK: Actions
    private func setupActions() {
        recalculateButton.addTarget(self, action: #selector(reCalculate), for: .touchUpInside)
    }
    
    @objc private func reCalculate() {
        navigationController?.popViewController(animated: true)
    }
}
