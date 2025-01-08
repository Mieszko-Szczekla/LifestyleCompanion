//
//  ContentView.swift
//  Example
//
//  Created by Mieszko Szczekla on 28/10/2024.
//

import SwiftUI


struct ContentView: View {
    @State var selection = 2
    @State var pickerColor = Color.green
    @State var onboardingComplete = true
    var body: some View {
        if onboardingComplete {
            TabView(selection: $selection) {
                Tab("Water", systemImage: "drop", value: 0) {
                    WaterView()
                }
                Tab("Breathing", systemImage: "leaf", value: 1) {
                    BreathingView()
                }
                Tab("Home", systemImage: "house", value: 2) {
                    HomeView()
                }
                Tab("Pills", systemImage: "pill", value: 3) {
                    PillsView()
                }
                Tab("Goals", systemImage: "medal.star.fill", value: 4) {
                    GoalsView()
                }
            }.accentColor(
                selection == 0 ? colorWater :
                selection == 1 ? colorBreathing :
                selection == 2 ? colorHome :
                selection == 3 ? colorPills :
                        colorGoals
            )
        } else {
            OnboardingView(onboardingCompleted: $onboardingComplete)
        }
    }
}

#Preview {
    ContentView()
}