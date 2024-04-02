//
//  ItemDetailsView.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI

struct ItemDetailsView: View {
    @State private var initialItem: Item
    @Binding var updatedItem: Item
    
    @State private var saveItemError = false
    @State private var didMakeChanges = false
    @State private var didSaveUpdates = false
    
    init(item: Binding<Item>, initialValue: Item) {
        self._updatedItem = item
        self._initialItem = State(initialValue: initialValue)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            TitledTextField(title: "Title", text: $updatedItem.title, placeholder: "What do you need to do?", didMakeChanges: $didMakeChanges)
            
            Divider()
            
            TitledTextField(title: "Description", text: $updatedItem.description, placeholder: "Add a brief description.", didMakeChanges: $didMakeChanges)
            
            Divider()
            
            StatusMenu(itemStatus: $updatedItem.status, didMakeChanges: $didMakeChanges)
            
            Divider()
            
            PriorityMenu(itemPriority: $updatedItem.priority, didMakeChanges: $didMakeChanges)
            
            Spacer()
            
            if initialItem.isDifferent(comparedTo: updatedItem) {
                CTAButton(title: "Update") {
                    Task {
                        do {
                            try await IM.shared.save(updatedItem)
                            didSaveUpdates = true
                        } catch {
                            saveItemError = true
                            updatedItem = initialItem
                        }
                    }
                }
                .alert("Alert", isPresented: $saveItemError) {
                    Button("Dismiss", role: .cancel) {}
                } message: {
                    Text("Error updating item.")
                }
                .alert("Success!", isPresented: $didSaveUpdates) {
                    Button("Dismiss", role: .cancel) {
                        initialItem = updatedItem
                    }
                } message: {
                    Text("Item changes updated successfully.")
                }
            }
        }
        .padding()
        .navigationTitle("Details")
        .onDisappear {
            if didMakeChanges && !didSaveUpdates {
                updatedItem = initialItem
            }
        }
    }
}

#Preview {
    ItemDetailsView(item: .constant(Item(id: "abc123", authorId: "123456789", title: "Take A Break", description: "Make sure to take a break and rest your eyes", status: .todo, priority: .medium, lastUpdatedBy: "123456789")), initialValue: Item(id: "abc123", authorId: "123456789", title: "Take A Break", description: "Make sure to take a break and rest your eyes", status: .todo, priority: .medium, lastUpdatedBy: "123456789"))
}
