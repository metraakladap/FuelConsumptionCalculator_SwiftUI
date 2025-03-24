//
//  ContentView.swift
//  FuelConsumptionCalculator_SwiftUI
//
//  Created by User on 24.03.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CalculatorScreen()
                .tabItem {
                    Image(systemName: "keyboard")
                }
            SavedScreen()
                .tabItem{
                    Image(systemName: "square.and.arrow.down")
                }
        }
    }
}

#Preview {
    ContentView()
}
