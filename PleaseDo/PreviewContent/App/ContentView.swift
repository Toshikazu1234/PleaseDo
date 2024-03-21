//
//  ContentView.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI

struct ContentView: View {
    @State private var vm = ListVM()
    
    var body: some View {
        NavigationStack(path: $vm.path) {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                TabView {
                    ListView(title: "To Do", items: $vm.todoItems) {
                        vm.path.append(.details)
                    }
                    
                    ListView(title: "In Progress", items: $vm.inProgressItems) {
                        vm.path.append(.details)
                    }
                    
                    ListView(title: "Done", items: $vm.doneItems) {
                        vm.path.append(.details)
                    }
                }
                .tabViewStyle(.page)
            }
            .toolbar {
                Button {
                    vm.path.append(.newItem)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
