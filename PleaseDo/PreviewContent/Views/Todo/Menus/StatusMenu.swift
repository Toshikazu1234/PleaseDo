//
//  StatusMenu.swift
//  PleaseDo
//
//  Created by R K on 3/24/24.
//

import SwiftUI

struct StatusMenu: View {
    @Binding var itemStatus: Status
    @Binding var didMakeChanges: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("Status:")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                
                Menu {
                    StatusMenuRow(status: .todo, itemStatus: $itemStatus, didMakeChanges: $didMakeChanges)
                    
                    StatusMenuRow(status: .inProgress, itemStatus: $itemStatus, didMakeChanges: $didMakeChanges)
                    
                    StatusMenuRow(status: .done, itemStatus: $itemStatus, didMakeChanges: $didMakeChanges)
                } label: {
                    Text(itemStatus.rawValue)
                        .foregroundStyle(.primary)
                }
            }
            Spacer()
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    StatusMenu(itemStatus: .constant(.todo), didMakeChanges: .constant(false))
}
