//
//  Item.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import Foundation
import FirebaseFirestore

struct Item: Identifiable, Equatable, Hashable {
    let id: String
    let authorId: String
    var title: String
    var description: String
    var startDate: Date = .now
    var status: Status
    var priority: Priority
    var lastUpdatedBy: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
    
    enum DBKeys: String {
        case id, authorId, title, description, startDate, status, priority, lastUpdatedBy
    }
    
    init(id: String, authorId: String, title: String, description: String, status: Status, priority: Priority, lastUpdatedBy: String) {
        self.id = id
        self.authorId = authorId
        self.title = title
        self.description = description
        self.status = status
        self.priority = priority
        self.lastUpdatedBy = lastUpdatedBy
    }
    
    init(data: [String: Any]) {
        self.id = data[DBKeys.id.rawValue] as! String
        self.authorId = data[DBKeys.authorId.rawValue] as! String
        self.title = data[DBKeys.title.rawValue] as! String
        self.description = data[DBKeys.description.rawValue] as! String
        self.startDate = (data[DBKeys.startDate.rawValue] as! Timestamp).dateValue()
        let statusString = data[DBKeys.status.rawValue] as! String
        self.status = Status(statusString)
        let priorityString = data[DBKeys.priority.rawValue] as! String
        self.priority = Priority(priorityString)
        self.lastUpdatedBy = data[DBKeys.lastUpdatedBy.rawValue] as! String
    }
    
    func toObject() -> [String: Any] {
        var data: [String: Any] = [:]
        data[DBKeys.id.rawValue] = id
        data[DBKeys.authorId.rawValue] = authorId
        data[DBKeys.title.rawValue] = title
        data[DBKeys.description.rawValue] = description
        data[DBKeys.startDate.rawValue] = Timestamp(date: .now)
        data[DBKeys.status.rawValue] = status.rawValue
        data[DBKeys.priority.rawValue] = priority.rawValue
        data[DBKeys.lastUpdatedBy.rawValue] = lastUpdatedBy
        return data
    }
    
    func isDifferent(comparedTo item: Item) -> Bool {
        return id != item.id
        || authorId != item.authorId
        || title != item.title
        || description != item.description
        || startDate != item.startDate
        || status != item.status
        || priority != item.priority
    }
    
    static func empty() -> Item {
        return Item(id: "", authorId: "", title: "", description: "", status: .todo, priority: .low, lastUpdatedBy: "")
    }
}
