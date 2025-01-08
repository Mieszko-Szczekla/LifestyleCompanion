//
//  GoalsView.swift
//  Example
//
//  Created by Mieszko Szczekla on 03/12/2024.
//
import SwiftUI


struct GoalsView: View {
    @ObservedObject var storedData: StoredData
    @ObservedObject var healthManager: HealthManager = HealthManager()
    @State var inputField: Int = 250
    @State var changedProperty: String = "Incorrect State"
    @State var modifyOverlay: Bool = false

    var body: some View {
        ZStack {
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
                        done: healthManager.calorieCount,
                        goal: storedData.calsGoal,
                        callback: energyCallback
                    )
                    RecommendationView(
                        icon: Image(systemName: "figure.walk"),
                        title: "Today's Steps",
                        color: colorSteps,
                        dark_secondary: colorStepsDark,
                        light_secondary: colorStepsLight,
                        detailed: true,
                        done: healthManager.stepCount,
                        goal: storedData.stepsGoal
                    )
                    RecommendationView(
                        icon: Image(systemName: "drop.fill"),
                        title: "Water intake",
                        color: colorWater,
                        dark_secondary: colorWaterDark,
                        light_secondary: colorWaterLight,
                        detailed: true,
                        unit: "mL",
                        done: storedData.waterNow,
                        goal: storedData.waterGoal
                    )
                    RecommendationView(
                        icon: Image(systemName: "leaf.fill"),
                        title: "Breathing exercises",
                        color: colorBreathing,
                        dark_secondary: colorBreathingDark,
                        light_secondary: colorBreathingLight,
                        detailed: true,
                        done: storedData.breathingNow,
                        goal: storedData.breathingGoal
                    )
                }
                .padding(8)
                }
            }
            modifyOverlay ? AnyView(ZStack {
                Rectangle().fill(.black).opacity(0.5).padding(.vertical, -100.0)
                RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
                        .fill(.background)
                        .frame(width:300, height:150)
                VStack {
                    Text(changedProperty)
                    TextField("", value: $inputField, formatter: NumberFormatter())
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .font(.system(size: 30))
                                    .frame(width: 250)
                    Button("Confirm") {
                        print("Hello")
                    }
                }
            }) : AnyView(EmptyView())
        }
    }
    
    func energyCallback() {
        inputField = 0
        changedProperty = "Change energy goal"
        modifyOverlay = true
    }
}


#Preview {
    GoalsView(storedData: StoredData())
}
