//
//  CalculatorScreen.swift
//  FuelConsumptionCalculator_SwiftUI
//
//  Created by User on 24.03.2025.
//

import SwiftUI
import Combine

struct CalculatorScreen: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        CalculatorView(viewModel: viewModel)
    }
}

struct CalculatorView: View {
    @ObservedObject var viewModel: MainViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    colorScheme == .dark ? Color.black : Color(UIColor.systemGray6),
                    colorScheme == .dark ? Color(UIColor.systemGray6) : Color.white
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 8) {
                    Text("Fuel Cost Calculator")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(colorScheme == .dark ? .white : Color(UIColor.systemIndigo))
                    
                    Text("Calculate your trip expenses")
                        .font(.subheadline)
                        .foregroundColor(Color(UIColor.systemGray))
                }
                .padding(.top, 30)
                .padding(.bottom, 20)
                
                
                VStack {
                    // Input fields
                    VStack(spacing: 16) {
                        CalculatorInputItem(
                            icon: "car.fill",
                            label: "Distance (km)",
                            placeholder: ""
                        ) { value in
                            viewModel.updateDistance(value)
                        }
                        
                        CalculatorInputItem(
                            icon: "drop.fill",
                            label: "Average Fuel Consumption (L/100km)",
                            placeholder: ""
                        ) { value in
                            viewModel.updateAverageFuelConsumption(value)
                        }
                        
                        CalculatorInputItem(
                            icon: "dollarsign.circle.fill",
                            label: "Fuel Price (per L)",
                            placeholder: ""
                        ) { value in
                            viewModel.updatePrice(value)
                        }
                        
                        CalculatorInputItem(
                            icon: "person.2.fill",
                            label: "Number of People",
                            placeholder: "1"
                        ) { value in
                            viewModel.updateNumberOfPeople(value)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 20)
                    
                    Divider()
                        .background(Color(UIColor.systemGray4))
                        .padding(.horizontal, 16)
                    
                    // Results section
                    VStack(spacing: 16) {
                       
                        let fuelNeeded = (viewModel.distance / 100) * viewModel.averageFuelConsumption
                        let fuelNeededText = String(format: "%.2f L", fuelNeeded)
                        
                        
                        let perPersonCost = Double(viewModel.state.result) ?? 0.0
                        let estimatedTotalCost = perPersonCost * viewModel.numberOfPeople
                        let totalCostText = String(format: "$%.2f", estimatedTotalCost)
                        
                        CalculatorOutputItem(
                            icon: "fuelpump.fill",
                            label: "Total Fuel Needed",
                            result: fuelNeededText
                        )
                        
                        CalculatorOutputItem(
                            icon: "creditcard.fill",
                            label: "Total Cost",
                            result: totalCostText
                        )
                        
                        CalculatorOutputItem(
                            icon: "person.fill.questionmark",
                            label: "Cost Per Person",
                            result: "$" + viewModel.state.result
                        )
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 20)
                }
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color(UIColor.systemBackground))
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
                )
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                
                Spacer()
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}


struct CalculatorInputItem: View {
    let icon: String
    let label: String
    let placeholder: String
    let onValueChange: (Double) -> Void

    @State private var text: String = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color(UIColor.systemGray))
            
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(Color(UIColor.systemIndigo))
                    .frame(width: 30)
                
                TextField(placeholder, text: $text)
                    .font(.system(size: 21))
                    .keyboardType(.decimalPad)
                    .focused($isFocused)
                    .onChange(of: text) { newValue in
                        let correctedValue = newValue.replacingOccurrences(of: ",", with: ".")
                        text = correctedValue
                        onValueChange(Double(correctedValue) ?? 0.0)
                    }

            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(UIColor.systemGray6))
            )
        }
        .toolbar {
            if isFocused {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button("Done") {
                            hideKeyboard()
                        }
                    }
                }
            }
        }
    }
}



struct CalculatorOutputItem: View {
    let icon: String
    let label: String
    let result: String
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color(UIColor.systemIndigo).opacity(0.1))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(Color(UIColor.systemIndigo))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color(UIColor.systemGray))
                
                Text(result)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
            }
            
            Spacer()
        }
    }
}
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


#Preview {
    CalculatorScreen()
}
