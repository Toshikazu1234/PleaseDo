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
                    ListView(status: .todo, items: $vm.todoItems, path: $path)
                    
                    ListView(status: .inProgress, items: $vm.inProgressItems, path: $path)
                    
                    ListView(status: .done, items: $vm.doneItems, path: $path)
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
                    ItemDetailsView(item: item)
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
