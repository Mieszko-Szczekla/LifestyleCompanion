//
//  GoalsView.swift
//  Example
//
//  Created by Mieszko Szczekla on 03/12/2024.
//
import SwiftUI


struct GoalsView: View {
    
    var body: some View {
        VStack {
            Text("Goals")
                .font(.title)
                .padding(30)
            ScrollView { VStack {
                RecommendationView(
                    icon: Image(systemName: "flame.fill"),
                    title: "Energy",
                    color: colorCalories,
                    dark_secondary: colorCaloriesDark,
                    light_secondary: colorCaloriesLight,
                    detailed: true,
                    unit: "kcal",
                    done: 123,
                    goal: 580
                )
                RecommendationView(
                    icon: Image(systemName: "figure.walk"),
                    title: "Today's Steps",
                    color: colorSteps,
                    dark_secondary: colorStepsDark,
                    light_secondary: colorStepsLight,
                    detailed: true,
                    done: 5423,
                    goal: 7000
                ).onAppear(){
                    //healthManager.getTodaySteps()
                }
                RecommendationView(
                    icon: Image(systemName: "drop.fill"),
                    title: "Water intake",
                    color: colorWater,
                    dark_secondary: colorWaterDark,
                    light_secondary: colorWaterLight,
                    detailed: true,
                    unit: "mL",
                    done: 750,
                    goal: 2250
                )
                RecommendationView(
                    icon: Image(systemName: "leaf.fill"),
                    title: "Breathing exercises",
                    color: colorBreathing,
                    dark_secondary: colorBreathingDark,
                    light_secondary: colorBreathingLight,
                    detailed: true,
                    done: 1,
                    goal: 3
                )
            }
                .padding(8)
            }
        }
    }
}


#Preview {
    GoalsView()
}
