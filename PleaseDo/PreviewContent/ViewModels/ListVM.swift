//
//  ListVM.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import Foundation

final class ListVM: ObservableObject {
    @Published var todoItems: [Item] = []
    @Published var inProgressItems: [Item] = []
    @Published var doneItems: [Item] = []
    @Published var unknownItems: [Item] = []
    
    @Published var initialItem = Item.empty()
    @Published var updatedItem = Item.empty()
    
    init() {
        IM.shared.listDelegate = self
    }
    
    func updatePriority() {
        guard !initialItem.isEmpty, !updatedItem.isEmpty else { return }
        if initialItem.priority != updatedItem.priority {
            switch updatedItem.status {
            case .todo:
                if let i = todoItems.firstIndex(of: updatedItem) {
                    todoItems[i] = updatedItem
                }
            case .inProgress:
                if let i = inProgressItems.firstIndex(of: updatedItem) {
                    inProgressItems[i] = updatedItem
                }
            case .done:
                if let i = doneItems.firstIndex(of: updatedItem) {
                    doneItems[i] = updatedItem
                }
            case .unknown:
                if let i = unknownItems.firstIndex(of: updatedItem) {
                    unknownItems[i] = updatedItem
                }
            }
        }
    }
    
    func updateStatus() {
        guard !initialItem.isEmpty, !updatedItem.isEmpty else { return }
        if initialItem.status != updatedItem.status {
            remove(initialItem)
            append(updatedItem)
        }
    }
    
    private func remove(_ item: Item) {
        switch item.status {
        case .todo:
            if let i = todoItems.firstIndex(of: item) {
                todoItems.remove(at: i)
            }
        case .inProgress:
            if let i = inProgressItems.firstIndex(of: item) {
                inProgressItems.remove(at: i)
            }
        case .done:
            if let i = doneItems.firstIndex(of: item) {
                doneItems.remove(at: i)
            }
        case .unknown:
            if let i = unknownItems.firstIndex(of: item) {
                unknownItems.remove(at: i)
            }
        }
    }
    
    private func append(_ item: Item) {
        switch item.status {
        case .todo:
            todoItems.append(item)
        case .inProgress:
            inProgressItems.append(item)
        case .done:
            doneItems.append(item)
        case .unknown:
            unknownItems.append(item)
        }
    }
}

extension ListVM: ItemsManagerListDelegate {
    func didFetchBatchItems(_ items: [Status : [Item]]) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
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
    }
    
    func didAddItem(_ item: Item) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            switch item.status {
            case .todo:
                todoItems.append(item)
            case .inProgress:
                inProgressItems.append(item)
            case .done:
                doneItems.append(item)
            case .unknown:
                unknownItems.append(item)
            }
        }
    }
    
    func didUpdateItem(_ item: Item) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
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
    }
    
    func didDeleteItem(_ item: Item) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
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
