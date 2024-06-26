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
    @Binding var shouldReDraw: Bool
    private let titleRadius: CGFloat = 10
    
    var body: some View {
        VStack(spacing: 0) {
            if shouldReDraw {
                EmptyView()
            }
            
            Text(status.rawValue)
                .font(.title2)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, maxHeight: 32)
                .background {
                    RoundedRectangle(cornerRadius: titleRadius)
                        .foregroundStyle(.orange)
                        .overlay {
                            RoundedRectangle(cornerRadius: titleRadius)
                                .stroke(.white, lineWidth: 2)
                        }
                }
                .padding(.horizontal)
                .padding(.top)
            
            List($items) { $item in
                NavigationLink(value: NavPath.details(item)) {
                    ListItemView(item: item, height: 100)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .listStyle(.insetGrouped)
    }
}

#Preview {
    ZStack {
        Color.background
            .ignoresSafeArea()
        
        ListView(status: .todo, items: .constant([
            Item(id: "abc123", authorId: "123456789", title: "Take A Break", description: "Make sure to take a break and rest your eyes", status: .todo, priority: .medium, lastUpdatedBy: "123456789"),
            Item(id: "123abc", authorId: "123456789", title: "Have A Snack", description: "Small snacks throughout the day are a great way to increase blood sugar for people with hypoglycemia", status: .todo, priority: .low, lastUpdatedBy: "123456789")
        ]), shouldReDraw: .constant(true))
    }
}
