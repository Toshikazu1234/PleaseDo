//
//  PrioritySelector.swift
//  PleaseDo
//
//  Created by R K on 3/24/24.
//

import SwiftUI

struct PrioritySelector: View {
    @Binding var itemPriority: Priority
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Status:")
                .font(.caption2)
                .foregroundStyle(.secondary)
            
            DisclosureGroup(isExpanded: $isExpanded) {
                DisclosureGroupPriorityRow(priority: .low, itemPriority: $itemPriority)
                
                DisclosureGroupPriorityRow(priority: .medium, itemPriority: $itemPriority)
                
                DisclosureGroupPriorityRow(priority: .high, itemPriority: $itemPriority)
            } label: {
                Text(itemPriority.rawValue)
                    .foregroundStyle(.primary)
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PrioritySelector(itemPriority: .constant(.low))
}
