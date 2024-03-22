//
//  Item.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI

struct Item: Identifiable, Equatable, Hashable {
    let id: String
    var title: String
    var description: String
    let startDate: TimeInterval
    let completedDate: TimeInterval?
    var status: Status
    var priority: Priority
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
}

enum Status: String, CaseIterable {
    case todo = "To Do"
    case inProgress = "In Progress"
    case done = "Done"
}

enum Priority: String, CaseIterable {
    case low, medium, high
    
    var color: Color {
        return switch self {
        case .low: .blue
        case .medium: .orange
        case .high: .red
        }
    }
    
    var img: String {
        return switch self {
        case .low: "circle"
        case .medium: "triangle"
        case .high: "exclamationmark.circle"
        }
    }
}
