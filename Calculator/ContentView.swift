//
//  ContentView.swift
//  Calculator
//
//  Created by Dhanu Bhardwaj on 02/02/23.
//

import SwiftUI
//import CoreData

enum CalculatorButtons :String {
    case allClear = "AC"
    case clear = "C"
    case divide = "/"
    case multiply = "*"
    case subtract = "-"
    case percentage = "%"
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
}

struct ContentView: View {
    @State var finalValue : String = "0"
    @State var expressionOperator:CalculatorButtons?
    @State var operand1:String? = "0"
    @State var operand2:String? = nil
    @State var isDecimalButtonClick:Bool = false
    @State var callExpression:String = ""

    let buttonArrays : [[CalculatorButtons]] = [[.allClear,.clear,.percentage,.divide],
                                                [.seven,.eight,.nine,.multiply],
                                                [.four,.five,.six,.subtract],
                                                [.one,.two,.three,.add],
                                                [.zero,.decimal,.equalTo]]
    
    let operators : [CalculatorButtons] = [.divide,.subtract,.add,.multiply,.percentage]
    let operatorInString:[String] = [CalculatorButtons.divide.rawValue,CalculatorButtons.subtract.rawValue,CalculatorButtons.add.rawValue,CalculatorButtons.multiply.rawValue,CalculatorButtons.percentage.rawValue]
//    func handleEqualTo()->String {
//        var result:String
//        switch(expressionOperator){
//        case .add:
//            result =  "\(self.operand1+self.operand2)"
//            break
//        case .subtract:
//            result =  "\(self.operand1-self.operand2)"
//            break
//
//        case .multiply:
//            result =  "\(self.operand1*self.operand2)"
//            break
//        case .divide:
//            result =  "\(self.operand1/self.operand2)"
//        case .percentage:
//            result =  String(self.operand1.truncatingRemainder(dividingBy: self.operand2))
//            break
//        default:
//           result = "0"
//            break
//        }
//        return result
//    }
//    func convertTextToDouble(exp:String){
//
//
//    }
    func removeLastOperatorAndDecimal() -> String {
        var expression: String = self.callExpression
        
        if(expression.count>0 && expression.last == "."){
            expression = String(expression.dropLast())
        }
        if(expression.count>0  && operatorInString.contains(String(expression.last!))){
            expression = String(expression.dropLast())
        }
       
        return expression
    }
    func evaluateExpression(){
        var expression = removeLastOperatorAndDecimal()
        if expression.count == 0{
            self.finalValue = "0"
            return ;
        }
        expression = convertExpressionToDouble(exp:Array(expression))
        print(expression)
        let number = NSExpression(format:expression).expressionValue(with: nil, context: nil) as! Double
        print(number)
        self.finalValue = String(format:"%g",number)
        self.operand1 =  self.finalValue
        self.operand2 = nil
        self.expressionOperator = nil
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
    
    func handleBackSpaceButton(){
//        let count =  self.callExpression.count-1
//        print( self.callExpression.prefix(count))
        self.callExpression = String(self.callExpression.dropLast())
        if( self.callExpression.count == 0){
            self.finalValue = "0"
            return
        }
        evaluateExpression()
    }
    
    func getLastOperand() -> String {
        let  exp = Array(self.callExpression)
        var result = ""
        var i = exp.count - 1
        while i >= 0 {
            if operatorInString.contains(String(exp[i])) {
                return result
            } else {
                result+=String(exp[i])
            }
            i-=1
        }
        return result
    }
    
    func handleCalculatorButtons(value:CalculatorButtons){
        print(value.rawValue)
        if(operators.contains(value)){
//            Add operator only either there is operand or operator is minus
            if(callExpression.count>0 || value == CalculatorButtons.subtract){
                if( callExpression.count>0 &&  operatorInString.contains(String(callExpression.last!))){
                    callExpression = String(callExpression.dropLast());
                }
                self.callExpression = self.callExpression + value.rawValue
            }
          
            print(self.callExpression)
            evaluateExpression()
        }
        else {
            switch(value){
            case .allClear:
                self.finalValue = "0"
                self.callExpression = ""
                self.isDecimalButtonClick = false
                break
            case .clear:
                handleBackSpaceButton()
                break
            case .equalTo:
                evaluateExpression()
                self.operand2 = nil
                break
            case .decimal:
                  let lastOperand = getLastOperand()
                if(lastOperand.contains(value.rawValue)){
                      return
                  }
                self.callExpression = self.callExpression + value.rawValue
                evaluateExpression()
                break
            default :
                if(self.finalValue == "0"){
                    self.finalValue = ""
                }
                self.callExpression = self.callExpression + value.rawValue
                evaluateExpression()
                break
            }
        }
    }
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            // Text to callExpression
            VStack{
                Spacer()
                VStack{
                    HStack{
                        Spacer()
                        Text(self.callExpression).bold().font(Font.custom("HelveticaNeue-Thin", size: 24)).foregroundColor(Color.black).padding()
                    }
                    HStack{
                        Spacer()
                        Text(self.finalValue).bold().font(Font.custom("HelveticaNeue-Thin", size: 78)).foregroundColor(Color.black).padding()
                    }
                }
               
    //  Buttons
                    ForEach(0...buttonArrays.count-1, id: \.self){
                        index in
                        HStack{
                            ForEach(self.buttonArrays[index],id: \.self){
                                buttonLabel in
                                Button(
                                 action: {
                                    self.handleCalculatorButtons(value: buttonLabel)
                                  },
                                  label:{
                                    Text(buttonLabel.rawValue).font(.system(size:26)).foregroundColor(Color.black)
                                        .frame(minWidth:70, maxWidth: buttonLabel == CalculatorButtons.zero ? .infinity :70, minHeight: 70, alignment: .center)
                                        .padding(10)
                                        .background(Color.orange)
                                })
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

