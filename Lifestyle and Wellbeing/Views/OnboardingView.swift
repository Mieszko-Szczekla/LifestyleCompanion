//
//  ProgressView.swift
//  Example
//
//  Created by Mieszko Szczekla on 28/10/2024.
//

import SwiftUI

struct OnboardingView: View {
    @State private var step: Int = 0
    @Binding var onboardingCompleted: Bool
    var body: some View {
        VStack {
            Text("Onboarding")
                .font(.title)
            Text("Progress is \(step*10)%")
                .font(.headline)
            Spacer()
            Button(action: {
                step += 1
                if step >= 10 {
                    withAnimation{
                        onboardingCompleted = true
                    }
                }
            }) {
                HStack {
                    Spacer()
                    Text("Continue")
                    Spacer()
                }
            }
                .padding()
                .background(Color.accentColor)
                .foregroundColor(Color.white)
                .cornerRadius(25)
                .padding(20)
            ProgressView(value: Float(step), total: 10)
        }
        .accentColor(Color(
            red: 1-(Double(step)/10),
            green: abs(0.5-(Double(step)/10)),
            blue: Double(step)/10
            ))

    }
}

#Preview {
    OnboardingView(onboardingCompleted: .constant(false))
}
