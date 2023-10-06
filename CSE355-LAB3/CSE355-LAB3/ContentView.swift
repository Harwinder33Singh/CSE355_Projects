//
//  ContentView.swift
//  CSE355-LAB3
//
//  Created by Harwinder Singh on 9/18/23.
//

import SwiftUI

struct ContentView: View {
    
    // Variables
    @State private var selectedCard: CardType = .visa
    @State var variable = CardDetails()
    @State private var showCard = false
    @State var textColor: Color = Color.black
    
    var body: some View {
        ZStack {
            NavigationView {
                Form {
                    // Form View
                    Section(header: Text("SIGNATURE")) {
                        TextField("Card Holder Name", text: $variable.holderName)
                        TextField("Bank", text: $variable.bank)
                        Picker("Card Type", selection: $variable.type) {
                            ForEach(CardType.allCases, id: \.self) { card in
                                Text(card.rawValue)
                            }
                        }
                    }
                    
                    Section(header: Text("DETAILS")) {
                        TextField("Card Number", text: $variable.number)
                        TextField("Secure Code", text: $variable.secureCode)
                        DatePicker("Valid Through", selection: $variable.validity, displayedComponents: .date)
                    }
                    
                    Section(header: Text("Card Color")) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(Colors.all, id: \.self) { color in
                                    Button(action: {
                                        self.variable.color = color
                                    }) {
                                        Circle()
                                            .fill(color)
                                            .frame(width: 50, height: 50)
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.white, lineWidth: self.variable.color == color ? 3 : 0)
                                            )
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                    Section {
                        Button("Add Card To Wallet") {
                            showCard = true
                            textColor = pickTextColor(for: self.variable.color)
                            variable.number = addSpace(cardNum: variable.number)
                            if variable.number.isEmpty || variable.holderName.isEmpty || variable.bank.isEmpty || variable.secureCode.isEmpty {
                                showCard = false
                            }
                        }.popover(isPresented: $showCard) {
                            // Popover window
                            VStack {
                                HStack{
                                    Text(variable.bank)
                                        .font(.largeTitle)
                                        .foregroundColor(textColor)
                                        .padding()
                                    Spacer()
                                    Text(variable.type.rawValue)
                                        .foregroundColor(textColor)
                                        .padding()
                                }
                                Spacer()
                                HStack{
                                    Text(variable.holderName)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(textColor)
                                        .padding()
                                    Spacer()
                                }
                                HStack{
                                    Text("Valid Through: \(variable.formattedValidity)")
                                        .foregroundColor(textColor)
                                    Text("Secure Code: \(variable.secureCode)")
                                        .foregroundColor(textColor)
                                }
                                HStack{
                                    Text(variable.number)
                                        .font(.headline)
                                        .foregroundColor(textColor)
                                        .fontWeight(.semibold)
                                        .multilineTextAlignment(.leading)
                                        .padding()
                                    Spacer()
                                }
                            }
                            .padding()
                            .background(variable.color)
                            .cornerRadius(10)
                            .frame(width: 350, height: 100)
                        }
                    }
                }.navigationTitle("Add Card")
            }
        }
    }
    
    func addSpace(cardNum: String) -> String {
        // To add space
        if cardNum.contains(" ") {
            return cardNum
        }
        var spacedNum = ""
        var currentIndex = 0
        
        for char in cardNum {
            if currentIndex > 0 && currentIndex % 4 == 0 {
                spacedNum.append(" ")
            }
            spacedNum.append(char)
            currentIndex += 1
        }
        return spacedNum
    }
    
    func pickTextColor(for selectedColor: Color) -> Color {
        // text color picker
        if selectedColor == Colors.blue || selectedColor == Colors.black {
            return Color.white
        }
        else {
            return Color.black
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
