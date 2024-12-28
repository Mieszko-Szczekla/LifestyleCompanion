//
//  HomeView.swift
//  Example
//
//  Created by Mieszko Szczekla on 28/10/2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var healthManager: HealthManager = HealthManager()
    
    var body: some View {
        VStack {
            Text("Welcome back")
                .font(.title)
                .padding(30)
            Spacer()
            VStack {
                RecommendationView(
                    icon: Image(systemName: "pill.fill"),
                    title: "Pills",
                    color: colorPills
                )
                HStack {
                    RecommendationView(
                        icon: Image(systemName: "flame.fill"),
                        title: "Calories",
                        color: colorCalories,
                        dark_secondary: colorCaloriesDark,
                        light_secondary: colorCaloriesLight,
                        scale: 0.8,
                        done: 234,
                        goal: 500
                    )
                    RecommendationView(
                        icon: Image(systemName: "figure.walk"),
                        title: "Steps",
                        color: colorSteps,
                        dark_secondary: colorStepsDark,
                        light_secondary: colorStepsLight,
                        scale: 0.8,
                        done: 4645,
                        goal: 7000
                    ).onAppear(){
                        healthManager.getTodaySteps()
                    }}.padding(0)
                HStack {
                    RecommendationView(
                        icon: Image(systemName: "drop.fill"),
                        title: "Water",
                        color: colorWater,
                        dark_secondary: colorWaterDark,
                        light_secondary: colorWaterLight,
                        scale: 0.8,
                        done: 750,
                        goal: 2250
                    )
                    RecommendationView(
                        icon: Image(systemName: "leaf.fill"),
                        title: "Breath",
                        color: colorBreathing,
                        dark_secondary: colorBreathingDark,
                        light_secondary: colorBreathingLight,
                        scale: 0.8,
                        done: 2,
                        goal: 3
                    )}
            }
        }.padding(6.0)
    }
}

#Preview {
    HomeView()
}
