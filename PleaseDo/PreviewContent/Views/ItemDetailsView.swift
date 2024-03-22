//
//  ItemDetailsView.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI

struct ItemDetailsView: View {
    @Binding var item: Item
    
    var body: some View {
        VStack(spacing: 0) {
            List {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Title:")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    
                    TextField("", text: $item.title, axis: .vertical)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Description:")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    
                    TextField("", text: $item.description, axis: .vertical)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Status:")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    
                    DisclosureGroup(item.status.rawValue) {
                        ForEach(0..<Status.allCases.count, id: \.self) { i in
                            let status = Status.allCases[i]
                            HStack {
                                Text(status.rawValue)
                                
                                Spacer()
                                
                                if item.status == status {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                    .frame(maxHeight: 75)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Priority:")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    
                    DisclosureGroup(item.priority.rawValue) {
                        ForEach(0..<Priority.allCases.count, id: \.self) { i in
                            let priority = Priority.allCases[i]
                            HStack {
                                Text(priority.rawValue)
                                
                                Spacer()
                                
                                if item.priority == priority {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                    .frame(maxHeight: 75)
                }
            }
            .scrollContentBackground(.hidden)
            .listStyle(.insetGrouped)
        }
        .toolbar {
            EditButton()
        }
    }
}

#Preview {
    ItemDetailsView(item: .constant(Item(id: "abc123", title: "Take A Break", description: "Make sure to take a break and rest your eyes", startDate: 1711043190, completedDate: nil, status: .todo, priority: .medium)))
}
