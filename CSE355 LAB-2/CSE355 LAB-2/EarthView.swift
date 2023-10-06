//
//  ContentView.swift
//  CSE355 LAB-2
//
//  Created by Harwinder Singh on 9/11/23.
//

import SwiftUI

struct EarthView: View {
    @State var weight: String = ""
    @State var dataFromMoon = ""
    
    // Converting weight into Double
    private var weightInDouble: Double {
        return Double(weight) ?? 0.0
    }
    var body: some View {
        NavigationStack {
            VStack {
                Text("Space Walk App")
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
                Image("EarthView")
                    .resizable()
                    .scaledToFit()
                Spacer()
                Text(dataFromMoon)
                    .font(.headline)
                    .fontWeight(.semibold)
                Spacer()
                Text("You are on Earth now")
                    .font(.headline)
                    .fontWeight(.semibold)
                Spacer()
                HStack {
                    Text("Enter your weight here: ")
                    Spacer()
                    TextField("", text: $weight)
                        .padding()
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                }.padding()
                NavigationLink("Go to Moon") {
                    // Pass data to the MoonView when navigating
                    MoonView(dataFromEarth: weightInDouble, dataFromMoon: $dataFromMoon, dataFromJupiter: "")
                }
                .padding()
                .border(.black, width: 2)
            }.navigationBarBackButtonHidden(true)
            .padding()
        }
    }
}

struct EarthView_Previews: PreviewProvider {
    static var previews: some View {
        EarthView()
    }
}
