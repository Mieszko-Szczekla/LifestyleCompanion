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
    @State var active: Bool = false
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
            active ? AnyView(Button("Stop") {
                print("Stop")
                active = false;
            }) : AnyView(VStack {
                BreathingCardView(title: "Relaxation", t1: 3, t2: 3, t3: 6, ss: startBreathing)
                BreathingCardView(title: "Stress", t1: 4, t2: 7, t3: 8,  ss: startBreathing)
            })
        }
        .padding(.bottom, 10)
    }
    
    func startBreathing(t1: Int, t2: Int, t3: Int, cycles: Int) {
        active = true
        switchSize(t1: t1, t2: t2, t3: t3, cycles: cycles)
    }
    
    func switchSize(t1: Int, t2: Int, t3: Int, cycles: Int) {
        if (cycles < 1 || !active){
            active = false
            storedData.setBreathingNow(now: storedData.breathingNow+1)
            return
        }
        withAnimation(.easeInOut(duration: TimeInterval(t1))){
            circleSize = 300
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + CGFloat(t1 + t2)) {
            withAnimation(.easeInOut(duration: TimeInterval(t1))){
                circleSize = 200
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + CGFloat(t1 + t2 + t3)) {
            switchSize(t1: t1, t2: t2, t3: t3, cycles: cycles - 1)
        }
    }
}


#Preview {
    BreathingView(storedData: StoredData())
}
