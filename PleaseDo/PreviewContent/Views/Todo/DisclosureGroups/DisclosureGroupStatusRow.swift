//
//  DisclosureGroupStatusRow.swift
//  PleaseDo
//
//  Created by R K on 3/24/24.
//

import SwiftUI

struct DisclosureGroupStatusRow: View {
    let status: Status
    @Binding var itemStatus: Status
    
    var body: some View {
        HStack {
            Text(status.rawValue)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            if itemStatus == status {
                Image(systemName: "checkmark")
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    DisclosureGroupStatusRow(status: .todo, itemStatus: .constant(.todo))
}
