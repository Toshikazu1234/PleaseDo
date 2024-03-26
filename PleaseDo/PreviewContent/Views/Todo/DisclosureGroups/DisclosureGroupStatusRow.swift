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
        Button {
            itemStatus = status
        } label: {
            HStack {
                Text(status.rawValue)
                
                Spacer()
                
                if itemStatus == status {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    DisclosureGroupStatusRow(status: .todo, itemStatus: .constant(.todo))
}
