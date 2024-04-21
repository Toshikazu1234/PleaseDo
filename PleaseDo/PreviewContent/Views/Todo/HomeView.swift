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
    @State private var path: [NavPath] = []
    @State private var showLogout = false
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                TabView {
                    ListView(status: .todo, items: $vm.todoItems, shouldReDraw: $vm.shouldReDraw)
                    
                    ListView(status: .inProgress, items: $vm.inProgressItems, shouldReDraw: $vm.shouldReDraw)
                    
                    ListView(status: .done, items: $vm.doneItems, shouldReDraw: $vm.shouldReDraw)
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
                        path.append(NavPath.newItem)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: NavPath.self) { path in
                switch path {
                case .newItem:
                    NewItemView(path: $path)
                case .details(let item):
                    switch item.status {
                    case .todo:
                        ItemDetailsView(initialItem: item, path: $path)
                            .environmentObject(vm)
                    case .inProgress:
                        ItemDetailsView(initialItem: item, path: $path)
                            .environmentObject(vm)
                    case .done:
                        ItemDetailsView(initialItem: item, path: $path)
                            .environmentObject(vm)
                    case .unknown:
                        EmptyView()
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
        .onAppear {
            vm.fetchItems()
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(LoginVM())
}
