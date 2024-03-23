//
//  SignUpFields.swift
//  PleaseDo
//
//  Created by R K on 3/23/24.
//

import SwiftUI

struct SignUpFields: View {
    @Binding var fname: String
    @Binding var lname: String
    @Binding var email: String
    @Binding var pw: String
    enum Field: Hashable {
        case fname, lname, email, pw
    }
    @FocusState private var isKeyboardFocused: Field?
    
    var body: some View {
        VStack(spacing: 12) {
            KeyboardView(placeholder: "First name", text: $fname, type: .default)
                .shadow(color: .gray, radius: 4, x: 1, y: 2.5)
                .focused($isKeyboardFocused, equals: .fname)
            
            KeyboardView(placeholder: "Last name", text: $lname, type: .default)
                .shadow(color: .gray, radius: 4, x: 1, y: 2.5)
                .focused($isKeyboardFocused, equals: .lname)
            
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
                    case .fname:
                        fname = ""
                    case .lname:
                        lname = ""
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
    SignUpFields(fname: .constant("John"), lname: .constant("Doe"), email: .constant("jd@email.com"), pw: .constant("abc123"))
}
