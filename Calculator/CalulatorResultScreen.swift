//
//  CalulatorResultScreen.swift
//  Calculator
//
//  Created by Dhanu Bhardwaj on 06/02/23.
//

import SwiftUI

struct CalulatorResultScreen: View {
    
    let currentExpression: String;
    let finalValue: String;
    init(currentExpression: String, finalValue: String){
        self.currentExpression = currentExpression;
        self.finalValue = finalValue;
    }
    
   
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text(currentExpression).bold().font(Font.custom("HelveticaNeue-Thin", size: 24)).foregroundColor(Color.black).padding()
            }
            HStack{
                Spacer()
                Text(finalValue).bold().font(Font.custom("HelveticaNeue-Thin", size: 78)).foregroundColor(Color.black).padding()
            }
        }
    }
}

//struct CalulatorResultScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        CalulatorResultScreen()
//    }
//}
