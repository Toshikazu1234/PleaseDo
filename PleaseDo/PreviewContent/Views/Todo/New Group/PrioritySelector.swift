//
//  PrioritySelector.swift
//  PleaseDo
//
//  Created by R K on 3/24/24.
//

import SwiftUI

struct PrioritySelector: View {
    @Binding var itemPriority: Priority
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("Status:")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                
                Menu {
                    DisclosureGroupPriorityRow(priority: .low, itemPriority: $itemPriority)
                    
                    DisclosureGroupPriorityRow(priority: .medium, itemPriority: $itemPriority)
                    
                    DisclosureGroupPriorityRow(priority: .high, itemPriority: $itemPriority)
                } label: {
                    Text(itemPriority.rawValue)
                        .foregroundStyle(.primary)
                }
            }
            Spacer()
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PrioritySelector(itemPriority: .constant(.low))
}
