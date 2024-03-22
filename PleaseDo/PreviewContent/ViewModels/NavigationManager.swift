//
//  NavigationManager.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI
import Observation

enum Path: Hashable {
    case newItem
    case details(NavItem)
}

@Observable final class NavigationManager {
    var path = NavigationPath()
    
    
}
