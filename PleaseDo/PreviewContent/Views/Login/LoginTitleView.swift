//
//  LoginTitleView.swift
//  PleaseDo
//
//  Created by R K on 3/23/24.
//

import SwiftUI

struct LoginTitleView: View {
    var body: some View {
        HStack {
            Image("PleaseDoLogo")
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(spacing: 3) {
                Text("Please Do")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                RoundedRectangle(cornerRadius: 5)
                    .frame(maxWidth: 175, maxHeight: 0.7)
                    .foregroundStyle(.gray)
                
                Text("A better todo list")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxHeight: 110)
        .padding(.horizontal)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    LoginTitleView()
}
