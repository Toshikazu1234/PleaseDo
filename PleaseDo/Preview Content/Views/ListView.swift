//
//  ListView.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI

struct ListView: View {
    let title: String
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.title)
                .frame(maxWidth: .infinity)
                .border(.white)
                .foregroundStyle(.white)
                .background {
                    Color.orange
                }
                .padding(.horizontal)
            
            List {
                
            }
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    ZStack {
        Color.background
            .ignoresSafeArea()
        
        ListView(title: "To Do")
    }
}
