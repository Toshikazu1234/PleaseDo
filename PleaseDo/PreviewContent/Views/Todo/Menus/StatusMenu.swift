//
//  StatusMenu.swift
//  PleaseDo
//
//  Created by R K on 3/24/24.
//

import SwiftUI

struct StatusMenu: View {
    @Binding var itemStatus: Status
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("Status:")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                
                Menu {
                    ForEach(Status.allCases, id: \.self) {
                        if $0 != .unknown {
                            StatusMenuRow(status: $0, itemStatus: $itemStatus)
                        }
                    }
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
    StatusMenu(itemStatus: .constant(.todo))
}
