//
//  ContentView.swift
//  CSE355 Lab-1
//
//  Created by Harwinder Singh on 9/3/23.
//  ASU ID: 1222095329

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Text("BMI CALCULATOR")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
                Spacer()
                // Navigation link to the ManualStyle view
                NavigationLink(destination: ManualStyle()) {
                    Text("Manual View")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.blue)
                }.buttonStyle(PlainButtonStyle())
                    
                Spacer()
                // Navigation link to the SliderStyle view
                NavigationLink(destination: SliderStyle()) {
                    Text("Slider View")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.blue)
                }.buttonStyle(PlainButtonStyle())
                Spacer()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
