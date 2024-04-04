//
//  ItemDetailsView.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI

struct ItemDetailsView: View {
    @EnvironmentObject var vm: ListVM
    let initialItem: Item
    @Binding var path: [NavPath]
    
    @State private var saveItemError = false
    @State private var didSaveUpdates = false
    
    var body: some View {
        VStack(spacing: 10) {
            TitledTextField(title: "Title", text: $vm.updatedItem.title, placeholder: "What do you need to do?")
            
            Divider()
            
            TitledTextField(title: "Description", text: $vm.updatedItem.description, placeholder: "Add a brief description.")
            
            Divider()
            
            StatusMenu()
            
            Divider()
            
            PriorityMenu()
            
            Spacer()
            
            if vm.initialItem.isDifferent(comparedTo: vm.updatedItem) {
                CTAButton(title: "Update") {
                    Task {
                        do {
                            try await IM.shared.save(vm.updatedItem)
                            vm.updateItem()
                            vm.updateStatus()
                            didSaveUpdates = true
                        } catch {
                            saveItemError = true
                            vm.updatedItem = initialItem
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
                        path.popToRoot()
                    }
                } message: {
                    Text("Item changes updated successfully.")
                }
            }
        }
        .padding()
        .navigationTitle("Details")
        .onAppear {
            vm.initialItem = initialItem
            vm.updatedItem = initialItem
        }
        .onDisappear {
            vm.initialItem = Item.empty()
            vm.updatedItem = Item.empty()
        }
    }
}

#Preview {
    ItemDetailsView(initialItem: Item(id: "abc123", authorId: "JohnDoe123", title: "Test item", description: "Test description", status: .todo, priority: .low, lastUpdatedBy: "JohnDoe123"), path: .constant([]))
}
