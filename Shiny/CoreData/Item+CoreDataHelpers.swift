//
//  Item+CoreDataHelpers.swift
//  Shiny
//
//  Created by Anton Novoselov on 09.02.2021.
//

import Foundation


extension Item {
    enum SortOrder {
        case optimized, title, creationDate
    }
    
    static var example: Item {
        let controller = DataController.preview
        let viewContext = controller.container.viewContext

        let item = Item(context: viewContext)
        item.title = "Example Item"
        item.detail = "This is an example item"
        item.priority = 3
        item.creationDate = Date()
        return item
    }
    
    
    var itemTitle: String {
        title ?? NSLocalizedString("New Item", comment: "")
    }

    var itemDetail: String {
        detail ?? ""
    }

    var itemCreationDate: Date {
        creationDate ?? Date()
    }
}
