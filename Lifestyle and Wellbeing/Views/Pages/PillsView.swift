//  PillsView.swift
//
//  Created by Mieszko Szczekla on 28/10/2024.
//

import SwiftUI

struct Pill : Identifiable {
    let id = UUID()
    var name: String
    var checked: Bool
}

var pills = [
    Pill(name: "Magnesium", checked: false),
    Pill(name: "Calcium", checked: true),
    Pill(name: "Vitamin D", checked: false),
]

struct PillsView: View {
    @ObservedObject var storedData: StoredData
    var body: some View {
        Text("Pills")
            .font(.title)
            .padding(30)
        List{
            ForEach(pills) { pill in
                HStack{
                    Button(action: {}) {
                        Image(systemName: pill.checked ? "checkmark.square.fill" : "square")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(colorPills)
                    }
                    .padding(.trailing, 10)
                    Text(pill.name)
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(Color(red:0.67, green:0.15, blue:0.11))
                    }
                }
                .padding(.vertical, 10)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    PillsView(storedData: StoredData())
}
