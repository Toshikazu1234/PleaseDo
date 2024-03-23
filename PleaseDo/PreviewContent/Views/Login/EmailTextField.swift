//
//  EmailTextField.swift
//  PleaseDo
//
//  Created by R K on 3/23/24.
//

import SwiftUI

struct EmailTextField: View {
    let showIcon: Bool
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        if showIcon {
            HStack(alignment: .center) {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 15)
                
                TextField(placeholder, text: $text)
                    .submitLabel(.done)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
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
            KeyboardView(placeholder: placeholder, text: $text, type: .emailAddress)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    EmailTextField(showIcon: true, placeholder: "test@email.com", text: .constant(""))
        .fixedSize()
        .shadow(color: .gray, radius: 4, x: 1, y: 2.5)
}
