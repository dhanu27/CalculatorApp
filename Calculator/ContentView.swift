//
//  ContentView.swift
//  Calculator
//
//  Created by Dhanu Bhardwaj on 02/02/23.
//

import SwiftUI

struct ContentView: View {
    @State var finalValue : String = "0"
    @State var callExpression:String = ""
    
    let buttonArrays : [[CalculatorButtons]] = [[.allClear,.clear,.percentage,.divide],
                                                [.seven,.eight,.nine,.multiply],
                                                [.four,.five,.six,.subtract],
                                                [.one,.two,.three,.add],
                                                [.zero,.decimal,.equalTo]]
    let operatorInString = "+-/*";
    let notANumber = "nan";
    let infinity = "inf";
    
    func formatExpression() -> String {
        var expression = removeLastOperatorAndDecimal(expression:self.callExpression)
        expression = convertExpressionToDouble(exp:Array(expression))
        return expression;
    }
    
    func evaluateExpression(isEqual: Bool = false){
        let fomattedExpression = formatExpression();
        if fomattedExpression.count == 0 {
            self.finalValue = "0"
            return ;
        }
        let number =  NSExpression(format:fomattedExpression).expressionValue(with: nil, context: nil) as! Double
        
        self.finalValue = String(format:"%g",number)
        if(isEqual){
            self.callExpression = self.finalValue;
            self.finalValue = CalculatorButtons.equalTo.rawValue + self.finalValue;
        }
    }
    
    func handleBackSpaceCTA(){
        //        Not to clear if user press "=" earlier
        if(self.finalValue.contains(CalculatorButtons.equalTo.rawValue)){
            return ;
        }
        self.callExpression = String(self.callExpression.dropLast())
        if( self.callExpression.count == 0){
            self.finalValue = "0"
            return
        }
//        evaluateExpression()
    }
    
    func getLastOperand() -> String {
        let  exp = Array(self.callExpression)
        var result = ""
        var i = exp.count - 1
        while i >= 0 {
            if operatorInString.contains(exp[i]) {
                return result
            } else {
                result+=String(exp[i])
            }
            i-=1
        }
        return result
    }
    
    func isExpressionContainInfinity () -> Bool {
        return self.callExpression == notANumber || self.callExpression == infinity
    }
    
    func handleCalculatorCTA(value:CalculatorButtons){
        var isEqualToPressed : Bool = false;
        if(isExpressionContainInfinity()){
            self.callExpression = "0"
            self.finalValue = "0"
        }
        switch(value){
        case .percentage ,.add ,.subtract, .multiply ,.divide :
            // Add operator only either there is operand or operator is minus
            if(callExpression.count>0 || value == CalculatorButtons.subtract){
                // Remove last operator with user enter again another one
                if( callExpression.count>0 &&  operatorInString.contains(callExpression.last!)){
                    callExpression = String(callExpression.dropLast());
                }
                self.callExpression = self.callExpression + value.rawValue;
            }
            break
        case .allClear:
            self.finalValue = "0"
            self.callExpression = ""
            break
        case .clear:
            handleBackSpaceCTA()
            break
        case .equalTo:
            isEqualToPressed = true
            break
        case .decimal:
            let lastOperand = getLastOperand()
            if(lastOperand.contains(value.rawValue)){
                return
            }
            self.callExpression = self.callExpression + value.rawValue
            break
        default :
            if(self.finalValue == "0"){
                self.finalValue = ""
            }
            self.callExpression = self.callExpression + value.rawValue
            break
        }
        evaluateExpression(isEqual: isEqualToPressed)
    }
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                
                CalulatorResultScreen(currentExpression: self.callExpression, finalValue: self.finalValue)
            
                ForEach(0...buttonArrays.count-1, id: \.self){
                    index in
                    HStack{
                        ForEach(self.buttonArrays[index],id: \.self){
                            buttonLabel in
                            Button(
                                action: {
                                    self.handleCalculatorCTA(value: buttonLabel)
                                }
                            ){
                                Text(buttonLabel.getDisplayValue())
                                    .font(.system(size:32))
                                    .foregroundColor(buttonLabel.getFontColor())
                                    .frame(minWidth:70, maxWidth: buttonLabel == CalculatorButtons.zero ? .infinity :70, minHeight: 70, alignment: .center)
                                    .padding(8)
                                    .overlay(RoundedRectangle(cornerRadius: 35)
                                        .stroke(.black, lineWidth: 2))
                            }
                            .background(buttonLabel.getBgColor()) // If you have this
                            .cornerRadius(35)
                        }
                    }
                }.padding(.bottom,3)
            }.padding()
        }
    }
}

struct ContentView_Previews :PreviewProvider{
    static var previews: some View{
        ContentView()
    }
    
}

