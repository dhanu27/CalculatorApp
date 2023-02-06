//
//  commonFunctions.swift
//  Calculator
//
//  Created by Dhanu Bhardwaj on 06/02/23.
//

import SwiftUI;

func removeLastOperatorAndDecimal(expression: String) -> String {
    var newExpression :String = expression;
    let operatorInString = "+-/*";
    if(newExpression.count>0 && newExpression.last == "."){
        newExpression = String(expression.dropLast())
    }
    if(newExpression.count>0  && operatorInString.contains(newExpression.last!)){
        newExpression = String(expression.dropLast())
    }
    
    return newExpression
}

func convertExpressionToDouble(exp:Array<Character>)-> String{
    let numbers = "0123456789" + ".,"
    var result = ""
    var i=0
    while i < exp.count {
        if numbers.contains(exp[i]) {
            var numString = String(exp[i])
            i += 1
            while i < exp.count {
                if numbers.contains(exp[i]) {
                    numString += String(exp[i])
                    i += 1
                } else {
                    break
                }
            }
            if let num = Double(numString) {
                result += "\(num)"
            } else {
                result += numString
            }
        } else {
            result += String(exp[i])
            i += 1
        }
    }
    return result
}
