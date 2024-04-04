//
//  PriorityMenu.swift
//  PleaseDo
//
//  Created by R K on 3/24/24.
//

import SwiftUI

struct PriorityMenu: View {
    @EnvironmentObject var vm: ListVM
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("Priority:")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                
                Picker("Priority", selection: $vm.updatedItem.priority) {
                    ForEach(Priority.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.menu)
            }
            Spacer()
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PriorityMenu()
}
