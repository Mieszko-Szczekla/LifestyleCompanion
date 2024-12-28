//  WaterView.swift
//
//  Created by Mieszko Szczekla on 28/10/2024.
//

import SwiftUI

struct WaterView: View {
    @State var waterCapacity: Int = 2250
    @State var waterIntake: Int = 750
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
                    height: CGFloat(Float(waterCapacity - waterIntake) * 500.0 / Float(waterCapacity)))
            Rectangle()
                .fill(LinearGradient(
                    colors: [colorWater, Color(red: 0.33, green: 0.5, blue: 1)],
                    startPoint: .bottom,
                    endPoint: .top
                ))
                .frame(
                    width: 200,
                    height: waterIntake > waterCapacity ? 500.0 : CGFloat(Float(waterIntake) * 500.0 / Float(waterCapacity))
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
                            if waterIntake-waterGlass < 0 {
                                waterIntake = 0
                            } else {
                                waterIntake -= waterGlass
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
                            if waterIntake+waterGlass > waterCapacity {
                                waterIntake = waterCapacity
                            } else {
                                waterIntake += waterGlass
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
    WaterView()
}
