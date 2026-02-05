//
//  BMI.swift
//  BMI Calculator
//
//  Created by Ekaterina Bastrikina on 02/02/2026.
//

import Foundation

struct BMI {
    let gender: Gender
    let height: Int
    let weight: Int
    let age: Int
}

enum Gender {
    case male
    case female
}
