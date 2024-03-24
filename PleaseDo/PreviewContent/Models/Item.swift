//
//  Item.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI
import FirebaseFirestore

struct Item: Identifiable, Equatable, Hashable {
    let id: String
    var title: String
    var description: String
    var startDate: Date = .now
    var status: Status
    var priority: Priority
    var isComplete: Bool = false
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
    
    enum DBKeys: String {
        case id, title, description, startDate, status, priority, isComplete
    }
    
    init(id: String, title: String, description: String, status: Status, priority: Priority) {
        self.id = id
        self.title = title
        self.description = description
        self.status = status
        self.priority = priority
    }
    
    init(data: [String: Any]) {
        self.id = data[DBKeys.id.rawValue] as! String
        self.title = data[DBKeys.title.rawValue] as! String
        self.description = data[DBKeys.description.rawValue] as! String
        self.startDate = (data[DBKeys.startDate.rawValue] as! Timestamp).dateValue()
        let statusString = data[DBKeys.status.rawValue] as! String
        self.status = Status(statusString)
        let priorityString = data[DBKeys.priority.rawValue] as! String
        self.priority = Priority(priorityString)
        self.isComplete = data[DBKeys.isComplete.rawValue] as! Bool
    }
    
    static func newObject(id: String, title: String, description: String, status: Status, priority: Priority) -> [String: Any] {
        var data: [String: Any] = [:]
        data[DBKeys.id.rawValue] = id
        data[DBKeys.title.rawValue] = title
        data[DBKeys.description.rawValue] = description
        data[DBKeys.startDate.rawValue] = Timestamp(date: .now)
        data[DBKeys.status.rawValue] = status.rawValue
        data[DBKeys.priority.rawValue] = priority.rawValue
        data[DBKeys.isComplete.rawValue] = false
        return data
    }
}

enum Status: String, CaseIterable {
    case todo = "To Do"
    case inProgress = "In Progress"
    case done = "Done"
    case unknown = "Unknown"
    
    init(_ str: String) {
        self = switch str {
        case "To Do": .todo
        case "In Progress": .inProgress
        case "Done": .done
        default: .unknown
        }
    }
}

enum Priority: String, CaseIterable {
    case low, medium, high, unknown
    
    init(_ str: String) {
        self = switch str {
        case "low": .low
        case "medium": .medium
        case "high": .high
        default: .unknown
        }
    }
    
    var color: Color {
        return switch self {
        case .low: .blue
        case .medium: .orange
        case .high: .red
        case .unknown: .gray
        }
    }
    
    var img: String {
        return switch self {
        case .low: "circle"
        case .medium: "triangle"
        case .high: "exclamationmark.circle"
        case .unknown: ""
        }
    }
}
