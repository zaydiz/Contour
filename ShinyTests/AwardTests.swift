//
//  AwardTests.swift
//  ShinyTests
//
//  Created by Anton Novoselov on 20.04.2021.
//

import XCTest
import CoreData

@testable import Shiny

class AwardTests: BaseTestCase {

    let awards = Award.allAwards
    
    func prepareValuesForTests() -> [Int] {
        return [1, 10, 20, 50, 100, 250, 500, 1000]
    }

    func testAwardIDMatchesName() {
        for award in awards {
            XCTAssertEqual(award.id, award.name,
                           "Award ID should always match its name.")
        }
    }

    func testNoAwards() throws {
        for award in awards {
            XCTAssertFalse(dataController.hasEarned(award: award),
                           "New users should have no earned awards")
        }
    }

    func testItemAwards() throws {
        let values = self.prepareValuesForTests()

        for (count, value) in values.enumerated() {
            var items = [Item]()

            for _ in 0..<value {
                let item = Item(context: managedObjectContext)
                items.append(item)
            }

            let matches = awards.filter { award in
                award.criterion == "items" && dataController.hasEarned(award: award)
            }

            XCTAssertEqual(matches.count, count + 1, "Adding \(value) items should unlock \(count + 1) awards.")

            for item in items {
                dataController.delete(item)
            }
        }
    }

    func testCompletedAwards() throws {
        let values = self.prepareValuesForTests()

        for (count, value) in values.enumerated() {
            var items = [Item]()

            for _ in 0..<value {
                let item = Item(context: managedObjectContext)
                item.completed = true
                items.append(item)
            }

            let matches = awards.filter { award in
                award.criterion == "complete" && dataController.hasEarned(award: award)
            }

            XCTAssertEqual(matches.count, count + 1, "Completing \(value) items should unlock \(count + 1) awards.")

            for item in items {
                dataController.delete(item)
            }
        }
    }

    func testAddingItems() {
        let values = self.prepareValuesForTests()

        for (count, value) in values.enumerated() {
            for _ in 0..<value {
                _ = Item(context: managedObjectContext)
            }

            let matches = awards.filter { award in
                award.criterion == "items" && dataController.hasEarned(award: award)
            }

            XCTAssertEqual(matches.count, count + 1, "Adding \(value) items should unlock \(count + 1) awards.")

            dataController.deleteAll()
        }
    }

    func testCompletingItemsFailed() {
        let values = self.prepareValuesForTests()
        for (count, value) in values.enumerated() {
            for _ in 0..<value {
                let item = Item(context: managedObjectContext)
                item.completed = true
            }

            let matches = awards.filter { award in
                award.criterion == "notComplete" && dataController.hasEarned(award: award)
            }

            XCTAssertEqual(matches.count, count + 1, "Completing \(value) items should unlock \(count + 1) awards.")

            dataController.deleteAll()
        }
    }
    

    func testCompletingItems() {
        let values = self.prepareValuesForTests()

        for (count, value) in values.enumerated() {
            for _ in 0..<value {
                let item = Item(context: managedObjectContext)
                item.completed = true
            }

            let matches = awards.filter { award in
                award.criterion == "complete" && dataController.hasEarned(award: award)
            }

            XCTAssertEqual(matches.count, count + 1, "Completing \(value) items should unlock \(count + 1) awards.")

            dataController.deleteAll()
        }
    }
}
