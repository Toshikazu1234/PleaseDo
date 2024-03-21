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
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                TabView {
                    ListView(title: "To Do")
                    
                    ListView(title: "In Progress")
                    
                    ListView(title: "Done")
                }
                .tabViewStyle(.page)
            }
            .toolbar {
                Button {
                    print("Navigate to NewItemView")
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
