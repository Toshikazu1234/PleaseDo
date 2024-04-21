//
//  Priority.swift
//  PleaseDo
//
//  Created by R K on 4/21/24.
//

import SwiftUI

enum Priority: String, CaseIterable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    case unknown = "Unknown"
    
    init(_ str: String) {
        self = switch str.lowercased() {
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
