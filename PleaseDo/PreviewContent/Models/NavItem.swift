//
//  NavItem.swift
//  PleaseDo
//
//  Created by R K on 3/30/24.
//

import Foundation

struct NavItem: Identifiable, Equatable, Hashable {
    var id: String {
        item.id
    }
    let item: Item
    let index: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: NavItem, rhs: NavItem) -> Bool {
        return lhs.id == rhs.id
    }
}
