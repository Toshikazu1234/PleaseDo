//
//  ItemsManager.swift
//  PleaseDo
//
//  Created by R K on 3/23/24.
//

import Foundation
import FirebaseFirestore

protocol ItemsManagerDelegate: AnyObject {
    
}

final class ItemsManager {
    weak var delegate: ItemsManagerDelegate?
    private let db = Firestore.firestore()
    var listener: ListenerRegistration?
    
    init() {
        listener = db.collection("Items").addSnapshotListener { [weak self] snapshot, err in
            if let err {
                print(err)
                return
            }
            guard let self, let snapshot else { return }
            
        }
    }
}
