//
//  ListVM.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import Foundation

@Observable final class ListVM {
    private let manager = ItemsManager()
    
    var todoItems: [Item] = [
        Item(id: "abc123", title: "Take A Break", description: "Make sure to take a break and rest your eyes", status: .todo, priority: .medium),
        Item(id: "123abc", title: "Have A Snack", description: "Small snacks throughout the day are a great way to increase blood sugar for people with hypoglycemia", status: .todo, priority: .low)
    ]
    
    var inProgressItems: [Item] = [
        Item(id: "xyz123", title: "Be Grateful", description: "Taking time everyday to be grateful is a habit that can dramatically change your life.", status: .inProgress, priority: .high)
    ]
    
    var doneItems: [Item] = []
    
    var unknownItems: [Item] = []
    
    init() {
        manager.delegate = self
    }
}

extension ListVM: ItemsManagerDelegate {
    func didFetchBatchItems(_ items: [Status : [Item]]) {
        if let todos = items[.todo] {
            todoItems = todos
        }
        if let itemsInProgress = items[.inProgress] {
            inProgressItems = itemsInProgress
        }
        if let done = items[.done] {
            doneItems = done
        }
        if let unknown = items[.unknown] {
            unknownItems = unknown
        }
    }
    
    func didFetchItem(_ item: Item) {
        if let i = todoItems.firstIndex(of: item) {
            if todoItems[i].status == item.status {
                todoItems[i] = item
            } else {
                todoItems.remove(at: i)
                moveItem(item)
            }
        } else if let i = inProgressItems.firstIndex(of: item) {
            if inProgressItems[i].status == item.status {
                inProgressItems[i] = item
            } else {
                inProgressItems.remove(at: i)
                moveItem(item)
            }
        } else if let i = doneItems.firstIndex(of: item) {
            if doneItems[i].status == item.status {
                doneItems[i] = item
            } else {
                doneItems.remove(at: i)
                moveItem(item)
            }
        } else {
            unknownItems.append(item)
        }
    }
    
    func didDeleteItem(_ item: Item) {
        if let i = todoItems.firstIndex(of: item) {
            todoItems.remove(at: i)
        }
        if let i = inProgressItems.firstIndex(of: item) {
            inProgressItems.remove(at: i)
        }
        if let i = doneItems.firstIndex(of: item) {
            doneItems.remove(at: i)
        }
        if let i = unknownItems.firstIndex(of: item) {
            unknownItems.remove(at: i)
        }
    }
    
    private func moveItem(_ item: Item) {
        switch item.status {
        case .todo:
            todoItems.append(item)
        case .inProgress:
            inProgressItems.append(item)
        case .done:
            doneItems.append(item)
        case .unknown:
            break
        }
    }
}
