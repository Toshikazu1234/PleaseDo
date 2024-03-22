//
//  ContentView.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI

struct ContentView: View {
    @State private var vm = ListVM()
    @State private var nav = NavigationManager()
    
    var body: some View {
        NavigationStack(path: $nav.path) {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                TabView {
                    ListView(status: .todo, items: $vm.todoItems)
                    
                    ListView(status: .inProgress, items: $vm.inProgressItems)
                    
                    ListView(status: .done, items: $vm.doneItems)
                }
                .tabViewStyle(.page)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        nav.path.append("NewItem")
                    } label: {
                        Image(systemName: "plus")
                    }
                }                
            }
            .navigationDestination(for: NavItem.self) { item in
                let i = item.index
                switch item.status {
                case .todo:
                    ItemDetailsView(item: $vm.todoItems[i])
                case .inProgress:
                    ItemDetailsView(item: $vm.inProgressItems[i])
                case .done:
                    ItemDetailsView(item: $vm.doneItems[i])
                }
            }
            .navigationDestination(for: String.self) { str in
                if str == "NewItem" {
                    NewItemView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
