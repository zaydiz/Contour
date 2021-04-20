//
//  ShinyTests.swift
//  ShinyTests
//
//  Created by Anton Novoselov on 19.04.2021.
//

import XCTest
import CoreData

@testable import Shiny

class BaseTestCase: XCTestCase {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
}
