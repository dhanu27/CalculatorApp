//
//  Enums.swift
//  Calculator
//
//  Created by Dhanu Bhardwaj on 05/02/23.
//

import Foundation
import SwiftUI

enum CalculatorButtons :String {
    case allClear = "AC"
    case clear = "C"
    case divide = "/"
    case multiply = "*"
    case subtract = "-"
    case percentage = "/100*"
    case add = "+"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case decimal = "."
    case equalTo = "="
    
    func getDisplayValue()->String{
        switch self {
        case .divide:
             return "÷"
        case .multiply:
            return "x"
        case .percentage:
           return "%"
        default:
            return self.rawValue
        }
    }
    
    func getFontColor()-> Color {
        switch self {
        case .allClear ,.clear ,.divide,.multiply,.percentage,.subtract,.add:
            return .black
        case .equalTo:
            return .black
        default:
            return .black
       
        }
    }
    
    func getBgColor()-> Color {
        switch self {
        case .allClear ,.clear ,.divide,.multiply,.percentage,.subtract,.add:
            return .mint
        case .equalTo:
            return .orange
        default:
            return Color(red: 0.5627, green: 0.8392, blue: 1.0)
       
        }
    }

}
