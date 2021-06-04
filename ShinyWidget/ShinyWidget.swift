//
//  ShinyWidget.swift
//  ShinyWidget
//
//  Created by Anton Novoselov on 04.06.2021.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
    func loadItems() -> [Item] {
        let dataController = DataController()
        let itemRequest = dataController.fetchRequestForTopItems(count: 1)
        return dataController.results(for: itemRequest)
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), items: [Item.example])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), items: loadItems())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let entry = SimpleEntry(date: Date(), items: loadItems())
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let items: [Item]
}

struct ShinyWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Up next…")
                .font(.title)
            if let item = entry.items.first {
                Text(item.itemTitle)
            } else {
                Text("Nothing!")
            }
        }
    }
}

@main
struct ShinyWidget: Widget {
    let kind: String = "ShinyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ShinyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct ShinyWidget_Previews: PreviewProvider {
    static var previews: some View {
        ShinyWidgetEntryView(entry: SimpleEntry(date: Date(), items: [Item.example]))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
