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
    @State var usedSetter: (Int) -> Void = {(x: Int) in print(x)}
    @State var warningDisplayed: Bool = false

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
                        callback: callback(
                            defaultInput: storedData.calsGoal,
                            promptName: "Enter calories (kcal)",
                            setter: storedData.setCalsGoal
                        )
                    )
                    RecommendationView(
                        icon: Image(systemName: "figure.walk"),
                        title: "Today's Steps",
                        color: colorSteps,
                        dark_secondary: colorStepsDark,
                        light_secondary: colorStepsLight,
                        detailed: true,
                        done: healthManager.stepCount,
                        goal: storedData.stepsGoal,
                        callback: callback(
                            defaultInput: storedData.stepsGoal,
                            promptName: "Enter number of steps",
                            setter: storedData.setStepsGoal
                        )
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
                        goal: storedData.waterGoal,
                        callback: callback(
                            defaultInput: storedData.waterGoal,
                            promptName: "Enter amount of water (mL)",
                            setter: storedData.setWaterGoal
                        )
                    )
                    RecommendationView(
                        icon: Image(systemName: "leaf.fill"),
                        title: "Breathing exercises",
                        color: colorBreathing,
                        dark_secondary: colorBreathingDark,
                        light_secondary: colorBreathingLight,
                        detailed: true,
                        done: storedData.breathingNow,
                        goal: storedData.breathingGoal,
                        callback: callback(
                            defaultInput: storedData.breathingGoal,
                            promptName: "Enter number of breathign sessions",
                            setter: storedData.setBreathingGoal
                        )
                    )
                }
                .padding(8)
                }
            }
            modifyOverlay ? AnyView(ZStack {
                Rectangle().fill(.black).opacity(0.5).padding(.vertical, -100.0)
                    .onTapGesture {
                        modifyOverlay=false
                    }
                RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
                        .fill(.background)
                        .frame(width:300, height:150)
                VStack {
                    Text(changedProperty)
                    VStack{
                        TextField("", value: $inputField, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.system(size: 30))
                        Button("Confirm") {
                            if (inputField > 0) {
                                usedSetter(inputField)
                                modifyOverlay = false
                            } else {
                                warningDisplayed = true
                            }
                        }
                    }
                    .frame(width: 250)
                    .alert("Number provided must be positive", isPresented: $warningDisplayed) {
                        Button("OK", role: .cancel) { }
                    }
                }
            }) : AnyView(EmptyView())
        }
    }
    
    func callback(
        defaultInput: Int,
        promptName: String,
        setter: @escaping (Int)->Void = {(x:Int) in print(x)}
    ) -> (() -> Void) {
        return { () in
            inputField = defaultInput
            changedProperty = promptName
            modifyOverlay = true
            usedSetter = setter
        }
    }
}


#Preview {
    GoalsView(storedData: StoredData())
}
