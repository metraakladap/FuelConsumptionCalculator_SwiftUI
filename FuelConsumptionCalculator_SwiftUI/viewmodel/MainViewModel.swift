//
//  MainViewModel.swift
//  FuelConsumptionCalculator_SwiftUI
//
//  Created by User on 24.03.2025.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    @Published var state: CalculatorState
    
    private var cancellables = Set<AnyCancellable>()
    var distance: Double = 0.0
    var averageFuelConsumption: Double = 0.0
    private var price: Double = 0.0
    var numberOfPeople: Double = 1.0
    
    init() {
        // Ініціалізуємо state перед використанням
        self.state = CalculatorState()
        
        // Не використовуємо sink для state, щоб уникнути циклічних викликів
        // і перевантаження stack frame
    }
    
    func updateDistance(_ value: Double) {
        distance = value
        calculateResult()
    }
    
    func updateAverageFuelConsumption(_ value: Double) {
        averageFuelConsumption = value
        calculateResult()
    }
    
    func updatePrice(_ value: Double) {
        price = value
        calculateResult()
    }
    
    func updateNumberOfPeople(_ value: Double) {
        numberOfPeople = max(1.0, value)
        calculateResult()
    }
    
    private func calculateResult() {
        // Використовуємо безпечне встановлення значення
        let result: String
        
        if distance > 0 && averageFuelConsumption > 0 && price > 0 && numberOfPeople > 0 {
            let totalConsumption = (distance / 100) * averageFuelConsumption
            let totalCost = totalConsumption * price
            let costPerPerson = totalCost / numberOfPeople
            result = String(format: "%.2f", costPerPerson)
        } else {
            result = "0.00"
        }
        
        // Оновлюємо state на головному потоці
        DispatchQueue.main.async {
            self.state.result = result
        }
    }
}

struct CalculatorState {
    var result: String = "0.00"
}
