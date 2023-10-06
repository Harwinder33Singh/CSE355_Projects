//
//  SliderStyle.swift
//  CSE355 Lab-1
//
//  Created by Harwinder Singh on 9/4/23.
//  ASU ID: 1222095329

import SwiftUI

struct SliderStyle: View {
    // Define state variables to store user input and calculated values
    @State var sliderWeight = 0.0
    @State var sliderHeight = 0.0
    @State var difference = 0.0
    @State var bmi: Double = 0.0
    @State var idealWeight: Double = 0.0
    @State var result: String = ""
    @State var colorStore: Color = .white
    
    var body: some View {
        VStack {
            Text("Ideal Weight")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
            
                Text("Weight (in pounds): \(String(format: "%.2f",sliderWeight))")
                
            // Slider used for weight and height input
            Slider(value: $sliderWeight, in: 1.0...500.0, step: 0.1 ).padding().onChange(of: sliderWeight, perform: { newValue in calculateBMI()})
            
            
                Text("Height (in inches): \(String(format: "%.2f",sliderHeight))")
                
            Slider(value: $sliderHeight, in: 1.0...100.0, step: 0.1 ).padding().onChange(of: sliderHeight, perform: { newValue in calculateBMI()})
            
            Spacer()
            
            Text("Your BMI: \(String(format: "%.2f",bmi))")
                
            Text("Your Ideal Weight: \(String(format: "%.2f",idealWeight))")
                
            Text(result).foregroundColor(colorStore)
                
            
        }
        .padding()
    }
    
    // Calculate BMI and update the result
    func calculateBMI() {
        self.bmi = (sliderWeight/(sliderHeight*sliderHeight))*703
        self.idealWeight = 5*bmi + ((bmi/5)*(sliderHeight - 60))
        print(sliderWeight)
        print(sliderHeight)
        
        difference = sliderWeight - idealWeight
        
        print(difference)
        
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
    }
}

struct SliderStyle_Previews: PreviewProvider {
    static var previews: some View {
        SliderStyle()
    }
}
