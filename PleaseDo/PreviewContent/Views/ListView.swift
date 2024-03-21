//
//  ListView.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI

struct ListView: View {
    let title: String
    @Binding var items: [Item]
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.title)
                .frame(maxWidth: .infinity)
                .border(.white)
                .foregroundStyle(.white)
                .background {
                    Color.orange
                }
                .padding(.horizontal)
            
            List($items) { $item in
                ListItemView(item: $item, height: 100)
            }
            .scrollContentBackground(.hidden)
            .listStyle(.insetGrouped)
        }
    }
}

#Preview {
    ZStack {
        Color.background
            .ignoresSafeArea()
        
        ListView(title: "To Do", items: .constant([
            Item(id: "abc123", title: "Take A Break", description: "Make sure to take a break and rest your eyes", startDate: 1711043190, completedDate: nil, status: .todo, priority: .medium),
            Item(id: "123abc", title: "Have A Snack", description: "Small snacks throughout the day are a great way to increase blood sugar for people with hypoglycemia", startDate: 1711043200, completedDate: nil, status: .todo, priority: .low)
        ]))
    }
}
