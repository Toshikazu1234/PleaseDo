//
//  PriorityMenuRow.swift
//  PleaseDo
//
//  Created by R K on 3/24/24.
//

import SwiftUI

struct PriorityMenuRow: View {
    let priority: Priority
    @Binding var itemPriority: Priority
    
    var body: some View {
        Button {
            itemPriority = priority
        } label: {
            HStack {
                Text(priority.rawValue)
                
                Spacer()
                
                if itemPriority == priority {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PriorityMenuRow(priority: .low, itemPriority: .constant(.low))
}
