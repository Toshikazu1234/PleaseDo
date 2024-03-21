//
//  ListVM.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import Foundation
import Observation

@Observable final class ListVM {
    var todoItems: [Item] = [
        Item(id: "abc123", title: "Take A Break", description: "Make sure to take a break and rest your eyes", startDate: 1711043190, completedDate: nil, status: .todo, priority: .medium),
        Item(id: "123abc", title: "Have A Snack", description: "Small snacks throughout the day are a great way to increase blood sugar for people with hypoglycemia", startDate: 1711043200, completedDate: nil, status: .todo, priority: .low)
    ]
    
    var inProgressItems: [Item] = [
        Item(id: "xyz123", title: "Be Grateful", description: "Taking time everyday to be grateful is a habit that can dramatically change your life.", startDate: 1711043500, completedDate: nil, status: .inProgress, priority: .high)
    ]
    
    var doneItems: [Item] = [
        
    ]
}
