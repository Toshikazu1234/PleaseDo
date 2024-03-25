//
//  NewItemVM.swift
//  PleaseDo
//
//  Created by R K on 3/24/24.
//

import Foundation
import Observation
import FirebaseAuth

@Observable final class NewItemVM {
    private let auth = Auth.auth()
    
    var newItem = Item(
        id: "",
        authorId: "",
        title: "",
        description: "",
        status: .todo,
        priority: .low)
    
    init() {
        guard let user = auth.currentUser else { return }
        newItem = Item(
            id: UUID().uuidString,
            authorId: user.uid,
            title: "",
            description: "",
            status: .todo,
            priority: .low)
    }
    
    func saveNewItem() async throws {
        try await IM.shared.saveNew(newItem)
    }
}
