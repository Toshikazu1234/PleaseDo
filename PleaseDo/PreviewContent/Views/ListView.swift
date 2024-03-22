//
//  ListView.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI

struct ListView: View {
    let status: Status
    @Binding var items: [Item]
    
    var body: some View {
        List {
            ForEach(0..<items.count, id: \.self) { i in
                let item = items[i]
                let navItem = NavItem(
                    status: item.status,
                    item: item,
                    index: i)
                let path = Path.details(navItem)
                NavigationLink(value: path) {
                    ListItemView(item: item, height: 100)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .listStyle(.insetGrouped)
        .navigationTitle(status.rawValue)
    }
}

#Preview {
    ZStack {
        Color.background
            .ignoresSafeArea()
        
        ListView(status: .todo, items: .constant([
            Item(id: "abc123", title: "Take A Break", description: "Make sure to take a break and rest your eyes", startDate: 1711043190, completedDate: nil, status: .todo, priority: .medium),
            Item(id: "123abc", title: "Have A Snack", description: "Small snacks throughout the day are a great way to increase blood sugar for people with hypoglycemia", startDate: 1711043200, completedDate: nil, status: .todo, priority: .low)
        ]))
    }
}
