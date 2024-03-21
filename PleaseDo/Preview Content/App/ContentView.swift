//
//  ContentView.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                ListView(title: "To Do")
                
                ListView(title: "In Progress")
                
                ListView(title: "Done")
            }
            .tabViewStyle(.page)
            .background {
                Color.background
            }
            .ignoresSafeArea()
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
