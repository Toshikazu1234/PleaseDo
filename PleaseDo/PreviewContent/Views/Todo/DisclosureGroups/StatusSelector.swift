//
//  StatusSelector.swift
//  PleaseDo
//
//  Created by R K on 3/24/24.
//

import SwiftUI

struct StatusSelector: View {
    @Binding var itemStatus: Status
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Status:")
                .font(.caption2)
                .foregroundStyle(.secondary)
            
            DisclosureGroup(isExpanded: $isExpanded) {
                DisclosureGroupStatusRow(status: .todo, itemStatus: $itemStatus)
                
                DisclosureGroupStatusRow(status: .inProgress, itemStatus: $itemStatus)
                
                DisclosureGroupStatusRow(status: .done, itemStatus: $itemStatus)
            } label: {
                Text(itemStatus.rawValue)
                    .foregroundStyle(.primary)
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    StatusSelector(itemStatus: .constant(.todo))
}
