//
//  ItemDetailsView.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI

struct ItemDetailsView: View {
    let item: Item
    @State private var stateItem: Item
    @State private var saveItemError = false
    
    init(item: Item) {
        self.item = item
        self._stateItem = State(initialValue: item)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            TitledTextField(title: "Title", text: $stateItem.title, placeholder: "What do you need to do?")
            
            Divider()
            
            TitledTextField(title: "Description", text: $stateItem.description, placeholder: "Add a brief description.")
            
            Divider()
            
            StatusSelector(itemStatus: $stateItem.status)
            
            Divider()
            
            PrioritySelector(itemPriority: $stateItem.priority)
            
            Spacer()
            
            if item.isDifferent(comparedTo: stateItem) {
                CTAButton(title: "Update") {
                    Task {
                        do {
                            try await IM.shared.save(stateItem)
                        } catch {
                            saveItemError = true
                        }
                    }
                }
                .alert("Alert", isPresented: $saveItemError) {
                    Button("Dismiss", role: .cancel) {}
                } message: {
                    Text("Error updating item.")
                }
            }
        }
        .padding()
        .navigationTitle("Details")
    }
}

#Preview {
    ItemDetailsView(item: Item(id: "abc123", authorId: "123456789", title: "Take A Break", description: "Make sure to take a break and rest your eyes", status: .todo, priority: .medium))
}
