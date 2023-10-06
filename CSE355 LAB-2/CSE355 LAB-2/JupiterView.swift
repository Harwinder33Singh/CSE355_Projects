//
//  JupiterView.swift
//  CSE355 LAB-2
//
//  Created by Harwinder Singh on 9/11/23.
//

import SwiftUI

struct JupiterView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var dataFromMoon: String
    var dataFromEarth: Double
    @State var weightOnMoon: Double = 0.0
    var body: some View {
            VStack {
                Text("You are on Jupiter")
                    .font(.title)
                    .fontWeight(.semibold)
                Image("JupiterView")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                Spacer()
                VStack{
                    Spacer()
                    Text("Your Weight on Jupiter is: \(String(format: "%.2f", 2.4*dataFromEarth))")
                        .font(.body)
                        .fontWeight(.semibold)
                    Text("Your Weight on Earth is: \(String(format: "%.2f", dataFromEarth))")
                        .font(.body)
                        .fontWeight(.semibold)
                    Text("Your Weight on Moon is: \(String(format: "%.2f", dataFromEarth/6))")
                        .font(.body)
                        .fontWeight(.semibold)
                    Spacer()
                    Text("I feel much heavier!!")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.purple)
                    Spacer()
                }
                NavigationLink("Go to Earth") {
                    // Sending data to earth view
                    EarthView(weight: String(dataFromEarth), dataFromMoon: "Coming From Jupiter.")
                }.padding()
                    .border(.black, width: 2)
                Button("Go to Moon") {
                    // Going back to moon
                    dataFromMoon = "Coming From Jupiter."
                    dismiss()
                }.padding()
                    .border(.black, width: 2)
            }.navigationBarBackButtonHidden(true)
        
    }
}

struct JupiterView_Previews: PreviewProvider {
    static var previews: some View {
        JupiterView(dataFromMoon: .constant(""), dataFromEarth: 0.0)
    }
}
