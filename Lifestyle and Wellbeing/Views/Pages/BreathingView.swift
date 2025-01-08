//
//  BreathingView.swift
//
//  Created by Mieszko Szczekla on 28/10/2024.
//

import SwiftUI

struct CustomLinearProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray.opacity(0.5))
            RoundedRectangle(cornerRadius: 25)
                .fill(colorBreathing)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 200)
        }
        .frame(width: 200, height: 50)
    }
}

struct BreathingView: View {
    @ObservedObject var storedData: StoredData
    @State var circleSize = CGFloat(200)
    var body: some View {
        VStack {
                Text("Breathing")
                    .font(.title)
                    .padding(30)
            Spacer()
            Circle()
                .fill(Color(red:0.45+circleSize/1024, green:circleSize/512, blue: 1))
                .shadow(color: colorBreathing, radius: circleSize/20)
                .frame(width: circleSize, height: circleSize)
            Spacer()
            BreathingCardView(title: "Relaxation", t1: 3, t2: 3, t3: 6)
            BreathingCardView(title: "Stress", t1: 4, t2: 7, t3: 8)
        }
        .padding(.bottom, 10)
    }
    
    func switchSize(numberOfSwitches: Int , cycleDuration: CGFloat) {
        if (numberOfSwitches < 1){
            return
        }
        withAnimation(.easeInOut(duration: cycleDuration/2)){circleSize = circleSize == 200 ? 300 : 200}
        DispatchQueue.main.asyncAfter(deadline: .now() + cycleDuration/2) {
            switchSize(numberOfSwitches: numberOfSwitches-1, cycleDuration: cycleDuration)
        }
    }
}


#Preview {
    BreathingView(storedData: StoredData())
}
