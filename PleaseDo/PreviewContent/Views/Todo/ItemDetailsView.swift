//
//  ItemDetailsView.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI

struct ItemDetailsView: View {
    @Binding var item: Item
    @State private var isStatusExpanded = false
    
    var body: some View {
        VStack(spacing: 10) {
            TitledTextField(title: "Title", text: $item.title, placeholder: "What do you need to do?")
            
            Divider()
            
            TitledTextField(title: "Description", text: $item.description, placeholder: "Add a brief description.")
            
            Divider()
            
            StatusSelector(itemStatus: $item.status)
            
            Divider()
            
            PrioritySelector(itemPriority: $item.priority)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Details")
    }
}

#Preview {
    ItemDetailsView(item: .constant(Item(id: "abc123", authorId: "123456789", title: "Take A Break", description: "Make sure to take a break and rest your eyes", status: .todo, priority: .medium)))
}
