//
//  HomeView.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var loginVM: LoginVM
    @StateObject private var vm = ListVM()
    @State private var nav = NavigationManager()
    @State private var showLogout = false
    
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
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showLogout = true
                    } label: {
                        Image(systemName: "person.circle")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        nav.path.append(Path.newItem)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Path.self) { path in
                switch path {
                case .newItem:
                    NewItemView()
                case .details(let item):
                    let i = item.index
                    switch item.status {
                    case .todo:
                        ItemDetailsView(item: vm.todoItems[i])
                    case .inProgress:
                        ItemDetailsView(item: vm.inProgressItems[i])
                    case .done:
                        ItemDetailsView(item: vm.doneItems[i])
                    case .unknown:
                        ItemDetailsView(item: vm.unknownItems[i])
                    }
                }
            }
            .confirmationDialog("Continue signing out?", isPresented: $showLogout) {
                Button("Confirm", role: .destructive) {
                    loginVM.signOut()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Continue signing out?")
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(LoginVM())
}
