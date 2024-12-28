//
//  BreathingCardView.swift
//  Example
//
//  Created by Mieszko Szczekla on 10/12/2024.
//

import SwiftUI

struct BreathingCardView: View {
    var title: String
    var t1: Int
    var t2: Int
    var t3: Int
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.headline)
                    .padding(.leading, 20)
                Spacer()
                Button("Start", systemImage: "play") {
                    
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .accentColor(colorBreathing)
                .padding(10)
                    
            }
            HStack {
                VStack{
                    Text("inhale")
                        .padding(.bottom, -4)
                        .opacity(0.65)
                        .font(.system(size: 16))
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color(red:0.65, green:0.33, blue: 0.86))
                        .frame(width: CGFloat(320*t1)/CGFloat(t1+t2+t3), height: 10)
                        .padding(.leading, 2)
                }
                VStack{
                    Text("hold")
                        .padding(.bottom, -4)
                        .opacity(0.65)
                        .font(.system(size: 16))
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color(red:0.81, green:0.57, blue: 0.98))
                        .frame(width: CGFloat(320*t2)/CGFloat(t1+t2+t3), height: 10)
                        .padding(.leading, 2)
                }
                VStack{
                    Text("exhale")
                        .padding(.bottom, -4)
                        .opacity(0.65)
                        .font(.system(size: 16))
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color(red:0.45, green:0.25, blue: 0.59))
                        .frame(width: CGFloat(320*t3)/CGFloat(t1+t2+t3), height: 10)
                        .padding(.leading, 2)
                }
            }
            .padding(.bottom, 20)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(colorTertiaryBackground)
                .shadow(color: colorBreathing, radius: 8)
        )
        .padding(10)
    }
}

#Preview {
    BreathingCardView(title: "Stress", t1: 4, t2: 7, t3: 8)
}
