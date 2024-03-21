//
//  ListItemView.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI

struct ListItemView: View {
    @Binding var item: Item
    let height: CGFloat
    
    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 3) {
                Text(item.title)
                    .font(.headline)
                
                Text(item.description)
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
            
            Image(systemName: item.priority.img)
                .resizable()
                .scaledToFit()
                .foregroundStyle(item.priority.color)
                .frame(maxHeight: height * 0.45)
        }
        .padding(.horizontal)
        .frame(maxHeight: height)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ListItemView(item: .constant(Item(id: "abc123", title: "Take A Break", description: "Make sure to take a break and rest your eyes", startDate: 1711043190, completedDate: nil, status: .todo, priority: .medium)), height: 100)
}
