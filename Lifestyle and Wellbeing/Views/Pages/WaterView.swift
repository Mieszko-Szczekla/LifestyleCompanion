//  WaterView.swift
//
//  Created by Mieszko Szczekla on 28/10/2024.
//

import SwiftUI

@MainActor struct WaterView: View {
    @ObservedObject var storedData: StoredData
    @State var waterGlass: Int = 250
    var body: some View {
        Text("Water")
            .font(.title)
            .padding([.top, .leading, .trailing], 30)
            .padding(.bottom, -40)
        Spacer()
        VStack {
            Rectangle()
                .hidden()
                .frame(
                    width: 200,
                    height: CGFloat(Float(storedData.waterGoal - storedData.waterNow) * 500.0 / Float(storedData.waterGoal)))
            Rectangle()
                .fill(LinearGradient(
                    colors: [colorWater, Color(red: 0.33, green: 0.5, blue: 1)],
                    startPoint: .bottom,
                    endPoint: .top
                ))
                .frame(
                    width: 200,
                    height: storedData.waterNow > storedData.waterGoal ? 500.0 : CGFloat(Float(storedData.waterNow) * 500.0 / Float(storedData.waterGoal))
                )
                
        }
        .frame(maxHeight: 492)
        .background(colorSecondaryBackground)
        .cornerRadius(30)
        .padding(.top, 30)
        .shadow(color: colorWater, radius: 10)
        
        Spacer()
        
                
        HStack {
            Image(systemName: "waterbottle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .foregroundColor(Color(red: 0.18824, green: 0.41569, blue: 0.8))
            
            TextField("capacity", value: $waterGlass, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.system(size: 30))
                            .frame(width: 120, height: 58)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth:2)
                            )
            
            
            Button(action: {
                        withAnimation {
                            if storedData.waterNow-waterGlass < 0 {
                                storedData.setWaterNow(now: 0)
                            } else {
                                storedData.setWaterNow(now: storedData.waterNow - waterGlass)
                            }
                        }
                    }) {
                        Image(systemName: "minus")
                            .foregroundColor(colorWater)
                            .frame(width: 60, height: 60)
                            .background(colorSecondaryBackground)
                            .cornerRadius(20)
                    }
            
            Button(action: {
                        withAnimation {
                            if storedData.waterNow+waterGlass > storedData.waterGoal {
                                storedData.setWaterNow(now: storedData.waterGoal)
                            } else {
                                storedData.setWaterNow(now: storedData.waterNow+waterGlass)
                            }
                        }
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(colorWater)
                            .cornerRadius(20)
                    }

        }
        
        //TextField("Goal", value: $waterCapacity, formatter: NumberFormatter()).textFieldStyle(RoundedBorderTextFieldStyle()).padding([.top, .leading, .trailing])
        
        
        

    }
}

#Preview {
    WaterView(storedData: StoredData())
}
