//
//  PasswordField.swift
//  PleaseDo
//
//  Created by R K on 3/23/24.
//

import SwiftUI

struct PasswordField: View {
    let showIcon: Bool
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        if showIcon {
            HStack(alignment: .center) {
                Image(systemName: "lock")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 15)
                
                SecureField(placeholder, text: $text)
                    .submitLabel(.done)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.default)
                    .background(.clear)
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.gray, lineWidth: 0.3)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.background)
                    )
            )
        } else {
            SecureField(placeholder, text: $text)
                .textFieldStyle(.roundedBorder)
                .submitLabel(.done)
                .textInputAutocapitalization(.never)
                .keyboardType(.default)
                .background(.clear)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PasswordField(showIcon: true, placeholder: "password", text: .constant(""))
        .fixedSize()
        .shadow(color: .gray, radius: 4, x: 1, y: 2.5)
}
