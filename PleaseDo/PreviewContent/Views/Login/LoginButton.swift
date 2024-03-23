//
//  LoginButton.swift
//  PleaseDo
//
//  Created by R K on 3/23/24.
//

import SwiftUI

struct LoginButton: View {
    let title: String
    let didTap: () -> Void
    
    var body: some View {
        Button(action: didTap) {
            HStack {
                Text(title)
                    .font(.largeTitle)
                    .padding()
                    .foregroundStyle(
                        LinearGradient(colors: [.lightGray, .white], startPoint: .leading, endPoint: .trailing)
                    )
                
                Image(systemName: "arrow.right")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 30, maxHeight: 30)
                    .padding(.trailing)
                    .foregroundStyle(.white)
            }
        }
        .background {
            LinearGradient(colors: [.dullBlue, .lightBlue], startPoint: .leading, endPoint: .trailing)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    LoginButton(title: "Login") {}
}
