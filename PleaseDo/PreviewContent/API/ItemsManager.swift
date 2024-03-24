//
//  ItemsManager.swift
//  PleaseDo
//
//  Created by R K on 3/23/24.
//

import Foundation
import FirebaseFirestore

protocol ItemsManagerDelegate: AnyObject {
    func didFetchBatchItems(_ items: [Status: [Item]])
    func didFetchItem(_ item: Item)
    func didDeleteItem(_ item: Item)
}

final class ItemsManager {
    weak var delegate: ItemsManagerDelegate?
    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?
    private var isInitialFetch = true
    
    /// Dictionary of dictionaries to sort all unique items by status
    /// - Parameters:
    ///   - Status: item.status
    ///   - String: item.id
    ///   - Item: item
    private var allItems: [Status: [String: Item]] = [
        .todo : [:],
        .inProgress : [:],
        .done : [:],
        .unknown : [:]
    ]
    
    init() {
        listener = db.collection("Items").addSnapshotListener { [weak self] snapshot, err in
            if let err {
                print("Error fetching docs: \(err)")
                return
            }
            guard let self, let snapshot else { return }
            snapshot.documentChanges.forEach { [weak self] diff in
                guard let self, diff.document.exists else { return }
                let data = diff.document.data()
                let item = Item(data: data)
                switch diff.type {
                case .added, .modified:
                    allItems[item.status]?[item.id] = item
                    guard !isInitialFetch else { break }
                    delegate?.didFetchItem(item)
                case .removed:
                    allItems[item.status]?.removeValue(forKey: item.id)
                    guard !isInitialFetch else { break }
                    delegate?.didDeleteItem(item)
                }
            }
            guard isInitialFetch else { return }
            sortBatchItems(from: snapshot.documents)
            isInitialFetch = false
        }
    }
    
    deinit {
        listener?.remove()
        listener = nil
    }
    
    private func sortBatchItems(from docs: [QueryDocumentSnapshot]) {
        var sortedItems: [Status: [Item]] = [:]
        allItems.keys.forEach { status in
            sortedItems[status] = allItems[status]?.values.sorted(by: {
                $0.startDate > $1.startDate
            })
        }
        delegate?.didFetchBatchItems(sortedItems)
    }
}
