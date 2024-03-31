//
//  StatusMenuRow.swift
//  PleaseDo
//
//  Created by R K on 3/24/24.
//

import SwiftUI

struct StatusMenuRow: View {
    let status: Status
    @Binding var itemStatus: Status
    @Binding var didMakeChanges: Bool
    
    var body: some View {
        Button {
            itemStatus = status
            print(itemStatus)
            didMakeChanges = true
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
    StatusMenuRow(status: .todo, itemStatus: .constant(.todo), didMakeChanges: .constant(false))
}
