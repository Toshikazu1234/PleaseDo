//
//  LoginFields.swift
//  PleaseDo
//
//  Created by R K on 3/23/24.
//

import SwiftUI

struct LoginFields: View {
    @Binding var email: String
    @Binding var pw: String
    enum Field: Hashable {
        case email, pw
    }
    @FocusState private var isKeyboardFocused: Field?
    
    var body: some View {
        VStack(spacing: 12) {
            EmailTextField(showIcon: true, placeholder: "user@email.com", text: $email)
                .shadow(color: .gray, radius: 4, x: 1, y: 2.5)
                .focused($isKeyboardFocused, equals: .email)
            
            PasswordField(showIcon: true, placeholder: "password", text: $pw)
                .shadow(color: .gray, radius: 4, x: 1, y: 2.5)
                .focused($isKeyboardFocused, equals: .pw)
        }
        .padding(.horizontal)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Cancel") {
                    guard let isKeyboardFocused else { return }
                    switch isKeyboardFocused {
                    case .email:
                        email = ""
                    case .pw:
                        pw = ""
                    }
                    self.isKeyboardFocused = nil
                }
                Button("Done") {
                    isKeyboardFocused = nil
                }
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    LoginFields(email: .constant(""), pw: .constant(""))
        .padding(.vertical)
}
