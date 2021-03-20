//
//  ContentView.swift
//  WeSplit
//
//  Created by Hithakshi on 20/03/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople: String = "2"
    @State private var tipPercentage = 2

    let minPeople = 2
    let maxPeople = 99

    var totalPeople: Int {
        (Int(self.numberOfPeople) ?? 0)
        // (Int(self.numberOfPeople) ?? 0) + minPeople
    }

    var totalAmount: Double {
        guard let amount = Int(checkAmount) else {
            return 0
        }
        let tipPercent = Double(tipPercentages[tipPercentage])/100
        return Double(amount) + (Double(amount) * tipPercent)
    }

    var sharePerPerson: Double {
        guard totalPeople > 0 else { return 0 }
        return totalAmount / Double(totalPeople)
    }

    let tipPercentages = [10, 15, 20, 25, 0]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter the check amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    Text("$\(checkAmount)")
                }
                Section(header: Text("How much tip would you like to leave?")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .textCase(.none)
                Section(header: Text("Total People")) {
                    TextField("Number of people: ", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
//                    Picker("Number of people: ", selection: $numberOfPeople) {
//                        ForEach(minPeople..<maxPeople+1) {
//                            Text("\($0) people")
//                        }
//                    }
                }
                Section(header: Text("Total Amount to be paid")
                ) {
                    Text("\(totalAmount, specifier: "%.2f")")
                }
                .textCase(.none)
                Section(header: Text("Amount per person")
                ) {
                    Text("\(sharePerPerson, specifier: "%.2f")")
                }
                .textCase(.none)
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
