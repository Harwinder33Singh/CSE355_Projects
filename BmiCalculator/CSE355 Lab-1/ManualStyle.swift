//
//  ManualStyle.swift
//  CSE355 Lab-1
//
//  Created by Harwinder Singh on 9/4/23.
//  ASU ID: 1222095329

import SwiftUI

struct ManualStyle: View {
    
    // Define state variables to store user input and calculated values
    @State var weight: String = ""
    @State var height: String = ""
    @State var bmi: Double = 0.0
    @State var idealWeight: Double = 0.0
    @State var result: String = ""
    @State var difference: Double = 0.0
    @State var colorStore: Color = .white
    
    // Converting weight and height in double from the user input
    private var weightInDouble: Double {
            return Double(weight) ?? 0.0
        }
    private var heightInDouble: Double {
            return Double(height) ?? 0.0
        }
    
    
    var body: some View {
        VStack {
            Text("Ideal Weight")
                .font(.largeTitle)
                .fontWeight(.bold)
                
            Spacer()
            
            HStack {
                Text("Weight (in pounds): ")
                Spacer()
                Spacer()
                TextField("Enter your weight", text:
                            $weight).keyboardType(.decimalPad)
            }
            HStack {
                Text("Height (in inches): ")
                Spacer()
                Spacer()
                TextField("Enter your height", text:
                            $height).keyboardType(.decimalPad)
            }
            
            Spacer()
            
            
            Button(action:{
                print(weightInDouble)
                // Calculate BMI and ideal weight based on user input
                bmi = (weightInDouble/((heightInDouble)*(heightInDouble)))*703
                idealWeight = 5*bmi + ((bmi/5)*(heightInDouble - 60))
                
                print(bmi)
                print()
                print(idealWeight)
                
                difference = weightInDouble - idealWeight
                
                // Determine the result and set the text color based on the difference
                if (difference > 20) {
                    result = "You are overweight"
                    colorStore = .red
                }
                
                if (difference < 20 && difference >= 10) {
                    result = "You need to control your weight"
                    colorStore = .blue
                }
                
                if (difference < 10 && difference >= 5) {
                    result = "You need to watch your weight gain"
                    colorStore = .purple
                }
                
                if (difference < 5 && difference > -5) {
                    result = "You are in good shape"
                    colorStore = .green
                }
                if (difference <= -5) {
                    result = "You need to eat more carb"
                    colorStore = .yellow
                }
                
            }) {
                Text("Calculate BMI and Ideal Weight")
                    .foregroundColor(Color.purple)
            }
            
            
            Spacer()
            Text(result).foregroundColor(colorStore)
            
        }
        .padding()
            }
}

struct ManualStyle_Previews: PreviewProvider {
    static var previews: some View {
        ManualStyle()
    }
}
