//  PillsView.swift
//
//  Created by Mieszko Szczekla on 28/10/2024.
//

import SwiftUI

struct PillsView: View {
    @ObservedObject var storedData: StoredData
    @ObservedObject var checklist: Checklist
    @State var warningDisplayed = false
    @State var deleteFunction: () -> Void = {() in}
    @State var questionDisplayed = false
    @State var nameOfNew: String = ""
    var body: some View {
        ZStack {
            VStack{
        Text("Pills")
            .font(.title)
            .padding(30)
        List{
            ForEach(checklist.getList()) { pill in
                HStack{
                    Button(action: {
                        checklist.toggleChecked(id: pill.id)
                    }) {
                        Image(systemName: pill.checked ? "checkmark.square.fill" : "square")
                            .resizable()
                            .foregroundColor(colorPills)
                    }
                    .buttonStyle(.borderless)
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 10)
                    Text(pill.name)
                    Spacer()
                    Button(action: {
                        deleteFunction = {() in
                            checklist.remove(id: pill.id)
                        }
                        warningDisplayed = true
                    }) {
                        Image(systemName: "trash")
                            .resizable()
                            .foregroundColor(Color(red:0.67, green:0.15, blue:0.11))
                    }
                    .buttonStyle(.borderless)
                    .frame(width: 18, height: 18)
                }
                .padding(.vertical, 10)
            }
        }
        .listStyle(.plain)
        .alert("Are you sure you want to delete?", isPresented: $warningDisplayed) {
            Button("Abort", role: .cancel) {  }
            Button("Delete", role: .destructive, action: deleteFunction)
        }
            Button(action: {
                nameOfNew = ""
                questionDisplayed = true
            }) {
            Image(systemName: "plus")
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .background(colorPills)
                .cornerRadius(20)
        }
                
            }
            questionDisplayed ? AnyView(ZStack {
                Rectangle().fill(.black).opacity(0.5).padding(.vertical, -100.0)
                    .onTapGesture {
                        questionDisplayed=false
                    }
                RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
                        .fill(.background)
                        .frame(width:300, height:150)
                VStack {
                    Text("Name of new pill: ")
                    VStack{
                        TextField("", text: $nameOfNew)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.system(size: 30))
                        Button("Confirm") {
                            if nameOfNew != "" {
                                checklist.add(name: nameOfNew)
                                questionDisplayed = false
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
}

#Preview {
    let c = Checklist()
    PillsView(storedData: StoredData(), checklist: c).onAppear {
        c.load(saved: "+Magnesium`-Aspirin`+Vitamin C")
    }
}
