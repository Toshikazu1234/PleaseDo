//
//  ItemDetailsView.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI

struct ItemDetailsView: View {
    @State private var item: Item
    @State private var updatedItem: Item
    @State private var saveItemError = false
    @State private var didUpdateItem = false
    
    init(item: Item) {
        self._item = State(initialValue: item)
        self._updatedItem = State(initialValue: item)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            TitledTextField(title: "Title", text: $updatedItem.title, placeholder: "What do you need to do?")
            
            Divider()
            
            TitledTextField(title: "Description", text: $updatedItem.description, placeholder: "Add a brief description.")
            
            Divider()
            
            StatusSelector(itemStatus: $updatedItem.status)
            
            Divider()
            
            PrioritySelector(itemPriority: $updatedItem.priority)
            
            Spacer()
            
            if item.isDifferent(comparedTo: updatedItem) {
                CTAButton(title: "Update") {
                    Task {
                        do {
                            try await IM.shared.save(updatedItem)
                            didUpdateItem = true
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
                .alert("Success!", isPresented: $didUpdateItem) {
                    Button("Dismiss", role: .cancel) {
                        item = updatedItem
                    }
                } message: {
                    Text("Item changes updated successfully.")
                }
            }
        }
        .padding()
        .navigationTitle("Details")
    }
}

#Preview {
    ItemDetailsView(item: Item(id: "abc123", authorId: "123456789", title: "Take A Break", description: "Make sure to take a break and rest your eyes", status: .todo, priority: .medium))
        .environmentObject(ListVM())
}
