//
//  SimpleWidget.swift
//  Shiny
//
//  Created by Anton Novoselov on 04.06.2021.
//

import SwiftUI
import WidgetKit

struct SimpleShinyWidget: Widget {
    let kind: String = "SimpleShinyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ShinyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
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

struct ShinyWidget_Previews: PreviewProvider {
    static var previews: some View {
        ShinyWidgetEntryView(entry: SimpleEntry(date: Date(), items: [Item.example]))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
