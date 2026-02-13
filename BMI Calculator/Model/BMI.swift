//
//  BMI.swift
//  BMI Calculator
//
//  Created by Ekaterina Bastrikina on 02/02/2026.
//

import UIKit

enum BMIStatus: String {
    case underweight = "UNDERWEIGHT"
    case healthy = "HEALTHY WEIGHT"
    case overweight = "OVERWEIGHT"
    case obesity = "OBESITY"
    
    var statusName: String { return self.rawValue }
    
    var uiColor: UIColor {
        switch self {
        case .underweight:
            return .cyan
        case .healthy:
            return .green
        case .overweight:
            return .orange
        case .obesity:
            return .red
        }
    }
    
    var description: String {
        switch self {
        case .underweight:
            return "You are below the normal body weight range. Consider consulting a healthcare professional for advice on healthy weight gain."
        case .healthy:
            return "You have a normal body weight. Good job! Keep maintaining a balanced diet and regular exercise."
        case .overweight:
            return "You are above the normal body weight range. Consider improving your diet and increasing physical activity."
        case .obesity:
            return "Your BMI indicates obesity. It is recommended to consult a healthcare professional for guidance and support."
        }
    }
}

struct BMI {
    let gender: Gender
    let height: Int
    let weight: Int
    let age: Int
    
    private var calculatedHeight: Double {
        sqrt((Double(height) / 10))
    }
    
    var calculatedBMI: Double {
         Double(weight) / Double(calculatedHeight)
    }
    
    var characteristics: (Int ,Gender, Double) {
        return (age, gender, calculatedBMI)
    }
    
    func result() -> BMIStatus {
        let status: BMIStatus
        switch calculatedBMI {
        case 0..<18.5:
            status = .underweight
        case 18.5..<24.9:
            status = .healthy
        case 24.9..<29.9:
            status = .overweight
        case 29.9...:
            status = .obesity
        default:
            status = .healthy
        }
        return status
    }
}

enum Gender: Int {
    case male
    case female
}
