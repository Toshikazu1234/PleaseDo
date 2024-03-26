//
//  NewItemView.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI

struct NewItemView: View {
    @State private var vm = NewItemVM()
    @State private var saveItemError = false
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            
            TitledTextField(title: "Title", text: $vm.newItem.title, placeholder: "What do you need to do?")
            
            Divider()
            
            TitledTextField(title: "Description", text: $vm.newItem.description, placeholder: "Add a brief description.")
            
            Divider()
            
            StatusSelector(itemStatus: $vm.newItem.status)
            
            Divider()
            
            PrioritySelector(itemPriority: $vm.newItem.priority)
            
            Spacer()
            
            CTAButton(title: "Confirm") {
                Task {
                    do {
                        try await vm.saveNewItem()
                    } catch {
                        saveItemError = true
                    }
                }
            }
            .alert("Alert", isPresented: $saveItemError) {
                Button("Dismiss", role: .cancel) {}
            } message: {
                Text("Error saving new item.")
            }
        }
        .padding(.horizontal)
        .navigationTitle("New Item")
    }
}

#Preview {
    NewItemView()
}
