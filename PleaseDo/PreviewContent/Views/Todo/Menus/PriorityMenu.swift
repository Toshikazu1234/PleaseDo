//
//  PriorityMenu.swift
//  PleaseDo
//
//  Created by R K on 3/24/24.
//

import SwiftUI

struct PriorityMenu: View {
    @Binding var itemPriority: Priority
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("Status:")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                
                Menu {
                    ForEach(Priority.allCases, id: \.self) {
                        if $0 != .unknown {
                            PriorityMenuRow(priority: $0, itemPriority: $itemPriority)
                        }
                    }
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
    PriorityMenu(itemPriority: .constant(.low))
}
