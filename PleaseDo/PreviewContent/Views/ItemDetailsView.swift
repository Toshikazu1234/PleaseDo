//
//  ItemDetailsView.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI

struct ItemDetailsView: View {
    @Binding var item: Item
    
    var body: some View {
        List {
            
        }
    }
}

#Preview {
    ItemDetailsView(item: .constant(Item(id: "abc123", title: "Take A Break", description: "Make sure to take a break and rest your eyes", startDate: 1711043190, completedDate: nil, status: .todo, priority: .medium)))
}
