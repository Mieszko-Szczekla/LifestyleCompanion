//
//  HealthManager.swift
//  Example
//
//  Created by Mieszko Szczekla on 28/10/2024.
//
import Foundation
import HealthKit
import SwiftUI

class HealthManager: ObservableObject {
    let healthStore = HKHealthStore()
    
    @Published var stepCount: Int = 0
    @Published var calorieCount: Int = 0
    
    init() {
        Task {
            try await healthStore.requestAuthorization(toShare: [], read: [
                HKQuantityType(.stepCount),
                HKQuantityType(.activeEnergyBurned)])
            getTodaySteps()
            getTodayCalories()
        }
    }
    
    private func getTodaySteps() {
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error==nil else {
                print("Error getting steps")
                return
            }
            Task { @MainActor in
                self.stepCount = Int(quantity.doubleValue(for: .count()))
            }

        }
        healthStore.execute(query)
    }
    
    private func getTodayCalories() {
        let cals = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
        let query = HKStatisticsQuery(quantityType: cals, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error==nil else {
                print("Error getting calories")
                return
            }
            Task { @MainActor in
                self.calorieCount = Int(quantity.doubleValue(for: HKUnit.kilocalorie()))
            }
        }
        healthStore.execute(query)
    }
}
