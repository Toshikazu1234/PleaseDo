//
//  ItemsManager.swift
//  PleaseDo
//
//  Created by R K on 3/23/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol ItemsManagerListDelegate: AnyObject {
    func didFetchBatchItems(_ items: [Status: [Item]])
    func didAddItem(_ item: Item)
    func didUpdateItem(_ item: Item)
    func didDeleteItem(_ item: Item)
}

typealias IM = ItemsManager
final class ItemsManager {
    static let shared = ItemsManager()
    weak var listDelegate: ItemsManagerListDelegate?
    
    private let db = Firestore.firestore()
    private lazy var itemsCollection = db.collection("Items")
    private var listener: ListenerRegistration?
    private var isInitialFetch = true
    
    /// Dictionary of dictionaries to sort all unique items by status.  Only used for initial fetch.
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
    
    private init() {
        fetchItems()
    }
    
    deinit {
        removeListener()
    }
    
    private func removeListener() {
        listener?.remove()
        listener = nil
    }
    
    func fetchItems() {
        guard let user = Auth.auth().currentUser else { return }
        removeListener()
        listener = itemsCollection.whereField("authorId", isEqualTo: user.uid).addSnapshotListener { [weak self] snapshot, err in
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
                case .added:
                    if isInitialFetch {
                        allItems[item.status]?[item.id] = item
                    } else {
                        listDelegate?.didAddItem(item)
                    }
                case .modified:
                    listDelegate?.didUpdateItem(item)
                case .removed:
                    listDelegate?.didDeleteItem(item)
                }
            }
            guard isInitialFetch else { return }
            sortBatchItems()
            isInitialFetch = false
        }
    }
    
    private func sortBatchItems() {
        var sortedItems: [Status: [Item]] = [:]
        allItems.keys.forEach { status in
            sortedItems[status] = allItems[status]?.values.sorted(by: {
                $0.startDate > $1.startDate
            })
        }
        listDelegate?.didFetchBatchItems(sortedItems)
        allItems.keys.forEach {
            allItems[$0] = [:]
        }
    }
    
    /// Writes to the Firebase collection "Items".
    /// Use to save a new item AND to update an existing item by overwriting it.
    func save(_ item: Item) async throws {
        guard let user = Auth.auth().currentUser else { throw Errors.noCurrentUser }
        var item = item
        item.lastUpdatedBy = user.uid
        do {
            try await itemsCollection.document(item.id).setData(item.toObject())
            print("Item saved successfully!")
        } catch {
            print(error)
            throw error
        }
    }
}
