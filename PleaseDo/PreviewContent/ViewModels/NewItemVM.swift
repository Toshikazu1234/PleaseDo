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
    
    var title = ""
    var description = ""
    var status: Status = .todo
    var priority: Priority = .low
    
    func saveNewItem() async throws {
        guard let user = auth.currentUser else {
            throw Errors.noCurrentUser
        }
        let item = Item(
            id: UUID().uuidString,
            authorId: user.uid,
            title: title,
            description: description,
            status: status,
            priority: priority)
        try await IM.shared.saveNew(item)
    }
}
