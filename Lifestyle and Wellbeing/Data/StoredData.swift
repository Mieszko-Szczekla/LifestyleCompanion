//
//  StoredData.swift
//  Lifestyle and Wellbeing
//
//  Created by Mieszko Szczekla on 28/12/2024.
//
import SwiftUI

@MainActor class StoredData : ObservableObject {
    private let defaults = UserDefaults.standard
    private let widget = UserDefaults(suiteName: "group.pwr.szczekla.Lifestyle_and_Wellbeing")
    
    @Published var waterGoal: Int = 0
    @Published var breathingGoal: Int = 0
    @Published var stepsGoal: Int = 0
    @Published var calsGoal: Int = 0
    
    @Published var waterNow: Int = 0
    @Published var breathingNow: Int = 0
    
    init() {
        waterGoal = defaults.integer(forKey: "waterGoal")
        waterGoal = waterGoal > 0 ? waterGoal : 2000
        
        breathingGoal = defaults.integer(forKey: "breathingGoal")
        breathingGoal = breathingGoal > 0 ? breathingGoal : 2
        
        stepsGoal = defaults.integer(forKey: "stepsGoal")
        stepsGoal = stepsGoal > 0 ? stepsGoal : 6000

        calsGoal = defaults.integer(forKey: "calsGoal")
        calsGoal = calsGoal > 0 ? calsGoal : 800

        waterNow = (StoredData.day() == defaults.integer(forKey: "waterExpire")) ? defaults.integer(forKey: "waterNow") : 0
        breathingNow = (StoredData.day() == defaults.integer(forKey: "breathingExpire")) ? defaults.integer(forKey: "breathingNow") : 0
        
        widget?.set(140*waterNow/waterGoal, forKey: "water")
        widget?.set(140*breathingNow/breathingGoal, forKey: "meditation")
    }
    
    func shouldResetChecklist() -> Bool {
        return StoredData.day() != defaults.integer(forKey: "checklistExpire")
    }
    
    func setChecklist() {
        defaults.set(StoredData.day(), forKey: "checklistExpire")
    }
    
    func setWaterGoal(goal: Int) {
        Task { @MainActor in
            if (goal <= 0) {
                return
            }
            waterGoal = goal
            defaults.set(goal, forKey: "waterGoal")
            widget?.set(140*waterNow/waterGoal, forKey: "water")
        }
    }
    
    func setCalsGoal(goal: Int) {
        Task { @MainActor in
            if (goal <= 0) {
                return
            }
            calsGoal = goal
            defaults.set(goal, forKey: "calsGoal")
        }
    }
    
    func setStepsGoal(goal: Int) {
        Task { @MainActor in
            if (goal <= 0) {
                return
            }
            stepsGoal = goal
            defaults.set(goal, forKey: "stepsGoal")
        }
    }
    
    func setBreathingGoal(goal: Int) {
        Task { @MainActor in
            if (goal <= 0) {
                return
            }
            breathingGoal = goal
            defaults.set(goal, forKey: "breathingGoal")
            widget?.set(140*breathingNow/breathingGoal, forKey: "meditation")
        }
    }
    
    func setWaterNow(now: Int){
        Task { @MainActor in
            waterNow = now
            defaults.set(now, forKey: "waterNow")
            defaults.set(StoredData.day(), forKey: "waterExpire")
            widget?.set(140*waterNow/waterGoal, forKey: "water")
        }
    }
    
    func setBreathingNow(now: Int){
        Task { @MainActor in
            breathingNow = now
            defaults.set(now, forKey: "breathingNow")
            defaults.set(StoredData.day(), forKey: "breathingExpire")
            widget?.set(140*breathingNow/breathingGoal, forKey: "meditation")
        }
    }
    
    static func day() -> Int {
        return Int(Date.now.timeIntervalSinceReferenceDate/60/60/24)
    }
}
