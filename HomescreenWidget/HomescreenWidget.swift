//
//  HomescreenWidget.swift
//  HomescreenWidget
//
//  Created by Mieszko Szczekla on 10/01/2025.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    private let defaults = UserDefaults(suiteName: "group.pwr.szczekla.Lifestyle_and_Wellbeing")
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(
            date: Date.now,
            //cals: 70,
            //steps: 43,
            water: 30,
            meditation: 70,
            meds: 130
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        
        let entry = SimpleEntry(
            date: Date.now,
            //cals: defaults?.value(forKey: "cals") as! CGFloat,
            //steps: defaults?.value(forKey: "steps") as! CGFloat,
            water: defaults?.value(forKey: "water") as! CGFloat,
            meditation: defaults?.value(forKey: "meditation") as! CGFloat,
            meds: defaults?.value(forKey: "meds") as! CGFloat
        )
        completion(entry)
    }

    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries = [SimpleEntry(
            date: Date.now,
            //cals: defaults?.value(forKey: "cals") as! CGFloat,
            //steps: defaults?.value(forKey: "steps") as! CGFloat,
            water: defaults?.value(forKey: "water") as! CGFloat,
            meditation: defaults?.value(forKey: "meditation") as! CGFloat,
            meds: defaults?.value(forKey: "meds") as! CGFloat
        )]

        let timeline = Timeline<SimpleEntry>(entries: entries, policy: .after(Date().addingTimeInterval(5000)))
            completion(timeline)
        }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    //let cals: CGFloat
    //let steps: CGFloat
    let water: CGFloat
    let meditation: CGFloat
    let meds: CGFloat
}

struct HomescreenWidgetEntryView : View {
    var entry: Provider.Entry
    func bar(color: Color, width: CGFloat, img: String) -> some View {
        var v: some View {
            ZStack {
                HStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(color)
                        .frame(width: width)
                        .padding(.trailing, -8)
                        .opacity(0.3)
                    Spacer()
                }
                HStack {
                    Image(systemName: img)
                        .padding(.vertical, -5.0)
                        .padding(.leading, 5)
                        .foregroundStyle(color)
                    Spacer()
                }
            }
        }

        return v
    }

    var body: some View {
        VStack {
            //bar(color: Color.orange, width: entry.cals, img: "flame.fill")
            //bar(color: Color(red: 0.39, green: 0.77, blue: 0.4), width: entry.steps, img: "figure.walk")
            bar(color: Color(red: 0.20392, green: 0.47059, blue: 0.96471), width: entry.water, img: "drop.fill")
            bar(color: Color(red: 0.61176, green: 0.40392, blue: 0.96863), width: entry.meditation, img: "leaf.fill")
            bar(color: Color(red: 0.91765, green: 0.26667, blue: 0.35294), width: entry.meds, img: "pill.fill")
        }.padding(-7)
    }
}

struct HomescreenWidget: Widget {
    let kind: String = "HomescreenWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                HomescreenWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                HomescreenWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Fitness Stats")
        .description("Shows fitness stats")
    }
}

#Preview(as: .systemSmall) {
    HomescreenWidget()
} timeline: {
    SimpleEntry(
        date: Date.now,
        //cals: 70,
        //steps: 140,
        water: 70,
        meditation: 140,
        meds: 83
    )
}
