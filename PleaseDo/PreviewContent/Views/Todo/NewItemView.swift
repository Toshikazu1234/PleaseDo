//
//  NewItemView.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI

struct NewItemView: View {
    @Binding var path: [NavPath]
    @State private var vm = NewItemVM()
    @State private var saveItemError = false
    @State private var didSaveItem = false
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            
            TitledTextField(title: "Title", text: $vm.newItem.title, placeholder: "What do you need to do?")
            
            Divider()
            
            TitledTextField(title: "Description", text: $vm.newItem.description, placeholder: "Add a brief description.")
            
            Divider()
            
            StatusMenu()
            
            Divider()
            
            PriorityMenu()
            
            Spacer()
            
            CTAButton(title: "Confirm") {
                Task {
                    do {
                        try await vm.saveNewItem()
                        didSaveItem = true
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
            .alert("Success!", isPresented: $didSaveItem) {
                Button("Dismiss", role: .cancel) {
                    path.removeLast()
                }
            } message: {
                Text("New item saved successfully.")
            }
        }
        .padding(.horizontal)
        .navigationTitle("New Item")
    }
}

#Preview {
    NewItemView(path: .constant([]))
}
