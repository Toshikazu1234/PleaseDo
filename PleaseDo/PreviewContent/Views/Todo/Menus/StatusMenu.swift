//
//  StatusMenu.swift
//  PleaseDo
//
//  Created by R K on 3/24/24.
//

import SwiftUI

struct StatusMenu: View {
    @EnvironmentObject var vm: ListVM
    let didChange: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("Status:")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                
                Picker("Status", selection: $vm.updatedItem.status) {
                    ForEach(Status.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.menu)
                .onChange(of: vm.updatedItem.status, didChange)
            }
            Spacer()
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    StatusMenu() {}
}
