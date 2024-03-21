//
//  Item.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI

struct Item: Identifiable, Equatable {
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

enum Status: String {
    case todo, inProgress, done
}

enum Priority: String {
    case low, medium, high
    
    var color: Color {
        switch self {
        case .low:
            return .blue
        case .medium:
            return .orange
        case .high:
            return .red
        }
    }
    
    var img: String {
        switch self {
        case .low:
            return "circle"
        case .medium:
            return "triangle"
        case .high:
            return "exclamationmark.octagon"
        }
    }
}
