//
//  RecommendationView.swift
//  Example
//
//  Created by Mieszko Szczekla on 28/10/2024.
//

import SwiftUI

struct RecommendationView: View {
    @Environment(\.colorScheme) var colorScheme
    var icon: Image
    var title: String
    
    var color: Color
    var dark_secondary: Color = .black
    var light_secondary: Color = .white
    
    var detailed: Bool = false
    var scale: CGFloat = 1
    
    var unit = ""
    var done = 0
    var goal = 1
    
    var callback: () -> Void = {() -> Void in return}
    
    var body: some View {
        HStack {
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40*scale , height: 40*scale)
                    .padding(.horizontal, scale < 1 ? 5.0 : 15.0)
                    .padding(.vertical, 15)
            VStack(alignment: detailed ? .leading : .trailing){
                    Text(title)
                        .font(.headline)
                    detailed ?
                        AnyView(Text(unit)
                            .font(.subheadline))
                      : AnyView(EmptyView())
                }
                .padding(.leading, 15*scale)
            Spacer()
            detailed ?
                AnyView(VStack(alignment: .trailing){
                    Text(String(done))
                        .font(.subheadline)
                    Text(String(goal))
                        .font(.subheadline)
                    }
                    .padding(.trailing, 15))
              : AnyView(EmptyView())
            detailed ? AnyView(Button(action: callback) {
                Image(systemName: "square.and.pencil.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            }) : AnyView(EmptyView())
        }
        .padding()
        .background(
            LinearGradient(
                stops: [
                    Gradient.Stop(color: ((colorScheme == .dark) ? dark_secondary : light_secondary), location: CGFloat(done)/CGFloat(goal)),
                    Gradient.Stop(color:colorTertiaryBackground, location: CGFloat(done)/CGFloat(goal))
                ],
                startPoint: .leading,
                endPoint: .trailing)
        )
        .foregroundStyle(color)
        .cornerRadius(10)
        //.padding([.top, .leading, .trailing], 15.0)
        .shadow(color: color.opacity(1), radius: 10, x: 0, y: 0)
        .padding(12.0)
    }
        
}

#Preview {
    RecommendationView(
        icon: Image(systemName: "flame.fill"),
        title: "Title",
        color: .orange,
        dark_secondary: Color(red: 0.49, green: 0.37, blue: 0.24),
        light_secondary: Color(red: 1, green: 0.95, blue: 0.89),
        detailed: true,
        done: 1,
        goal: 3
    )
}
