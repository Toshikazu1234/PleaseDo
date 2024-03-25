//
//  ContentView.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = LoginVM()
    
    var body: some View {
        switch vm.loginStatus {
        case .unknown:
            withAnimation(.easeInOut) {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(2)
            }
        case .loggedIn:
            withAnimation(.easeInOut) {
                HomeView()
                    .environmentObject(vm)
            }
        case .loggedOut:
            withAnimation(.easeInOut) {
                LoginView()
                    .environmentObject(vm)
            }
        }
    }
    
    init() {
        print("$$ ContentView init()")
        print("$$ ")
    }
}

#Preview {
    ContentView()
}
