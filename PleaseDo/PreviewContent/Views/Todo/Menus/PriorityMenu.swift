//
//  PriorityMenu.swift
//  PleaseDo
//
//  Created by R K on 3/24/24.
//

import SwiftUI

struct PriorityMenu: View {
    @Binding var priority: Priority
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("Priority:")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                
                Picker("Priority", selection: $priority) {
                    ForEach(Priority.allCases, id: \.self) {
                        if $0 == .unknown {
                            EmptyView()
                        } else {
                            Text($0.rawValue)
                        }
                    }
                }
                .pickerStyle(.menu)
            }
            Spacer()
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PriorityMenu(priority: .constant(.low))
}
