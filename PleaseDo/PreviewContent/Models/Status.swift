//
//  Status.swift
//  PleaseDo
//
//  Created by R K on 4/21/24.
//

import Foundation

enum Status: String, CaseIterable {
    case todo = "To Do"
    case inProgress = "In Progress"
    case done = "Done"
    case unknown = "Unknown"
    
    init(_ str: String) {
        self = switch str.lowercased() {
        case "to do": .todo
        case "in progress": .inProgress
        case "done": .done
        default: .unknown
        }
    }
}
