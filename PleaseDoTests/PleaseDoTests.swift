//
//  PleaseDoTests.swift
//  PleaseDoTests
//
//  Created by R K on 3/21/24.
//

import XCTest
@testable import PleaseDo

final class PleaseDoTests: XCTestCase {

    func testSetInsert() {
        // setup
        let localItem = Item(id: "abc123", authorId: "123456789", title: "Thing 1", description: "", status: .todo, priority: .low)
        let docChangeItem = Item(id: "abc123", authorId: "123456789", title: "Thing 1", description: "", status: .inProgress, priority: .low)
        let docChangedAgain = Item(id: "abc123", authorId: "123456789", title: "Thing 1", description: "", status: .done, priority: .low)
        
        // execute
        var items: Set<Item> = []
        items.insert(localItem)
        items.insert(docChangeItem)
        items.insert(docChangedAgain)
        let item = items.first!
        
        // assert
        XCTAssertEqual(localItem, docChangeItem)
        XCTAssertEqual(localItem, docChangedAgain)
        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(item.status, .todo)
        
        // Here we test to ensure only 1 Item gets inserted into Set.
        // This works because we override has(into:) and ==
        // An object can NOT be inserted into a Set that already contains an equal object.  i.e. Previously existing object in Set will retain, and new object will not be inserted.
    }

}
