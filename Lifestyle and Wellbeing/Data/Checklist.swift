//
//  Checklist.swift
//  Lifestyle and Wellbeing
//
//  Created by Mieszko Szczekla on 09/01/2025.
//
import SwiftUI

struct Pill : Identifiable {
    let id = UUID()
    var name: String
    var checked: Bool
}

class Checklist : ObservableObject {
    @Published var data: [Pill]
    @Published var done: Int = 0
    @Published var goal: Int = 1
    @ObservedObject private var sd = StoredData()
    private let defaults = UserDefaults.standard
    
    init() {
        let noReset = !StoredData().shouldResetChecklist()
        let saved: String = defaults.string(forKey: "checklist") ?? ""
        data = saved.split(separator: "`").map {
            return Pill(
                name: String($0[$0.index($0.startIndex, offsetBy: 1)...]),
                checked: noReset && ($0.first == "+")
            )
        }
        updateDone()
    }
    
    func load(saved: String) {
        data = saved.split(separator: "`").map {
            return Pill(
                name: String($0[$0.index($0.startIndex, offsetBy: 1)...]),
                checked: $0.first == "+"
            )
        }
    }
    
    func getList() -> [Pill] {
        return data
    }
    
    func toggleChecked(id: UUID) {
        for i in 0..<(data.count) {
            if(data[i].id == id) {
                data[i].checked = !data[i].checked
            }
        }
        save()
    }
    
    func remove(id: UUID) {
        data.removeAll(where: {(p: Pill) in p.id == id})
        save()
    }
    
    func add(name: String) {
        data.append(Pill(name: name, checked: false))
        save()
    }
    
    func save() {
        updateDone()
        var res: String = ""
        for pill in data {
            res += ((pill.checked ? "+" : "-") + pill.name + "`")
        }
        defaults.set(res, forKey: "checklist")
        sd.setChecklist()
    }
    
    func updateDone() {
        goal = data.count
        var n = 0
        for pill in data {
            if pill.checked {
                n+=1
            }
        }
        done = n
    }
    
    
}
