//
//  MoonView.swift
//  CSE355 LAB-2
//
//  Created by Harwinder Singh on 9/11/23.
//

import SwiftUI

struct MoonView: View {
    @Environment(\.dismiss) var dismiss
//    @Binding var dataSecond: String
    var dataFromEarth: Double
    @Binding var dataFromMoon: String
    @State var dataFromJupiter: String
    @State var weightOnMoon: Double = 0.0
    var body: some View {
        VStack {
            Text("You are on Moon")
                .font(.title)
                .fontWeight(.semibold)
            Image("MoonView")
                .resizable()
                .scaledToFit()
                .padding()
            Spacer()
            Text(dataFromJupiter)
                .font(.headline)
                .fontWeight(.semibold)
            Spacer()
            Text("Your Weight on Earth is: \(String(format: "%.2f", dataFromEarth))")
                .font(.body)
                .fontWeight(.semibold)
            Text("Your Weight on Moon is: \(String(format: "%.2f", dataFromEarth/6))")
                .font(.body)
                .fontWeight(.semibold)
            Spacer()
            Text("I feel much lighter!!")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(Color.purple)
            VStack {
                NavigationLink("Go to Jupiter") {
                    // Sending data to Jupiter View
                    JupiterView(dataFromMoon: $dataFromJupiter, dataFromEarth: dataFromEarth)
                }.padding()
                    .border(.black, width: 2)
                Button("Go to Earth") {
                    // Going back to Earth
                    dataFromMoon = "Coming from the moon."
                    dismiss()
                }.padding()
                    .border(.black, width: 2)
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct MoonView_Previews: PreviewProvider {
    static var previews: some View {
        MoonView(dataFromEarth: 0.0, dataFromMoon: .constant(""), dataFromJupiter: "")
    }
}
