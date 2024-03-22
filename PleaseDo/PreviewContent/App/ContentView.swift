//
//  ContentView.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI

struct ContentView: View {
    @State private var vm = LoginVM()
    
    var body: some View {
        switch vm.loginStatus {
        case .unknown:
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(2)
        case .loggedIn:
            HomeView()
        case .loggedOut:
            LoginView(vm: $vm)
        }
    }
}

#Preview {
    ContentView()
}
