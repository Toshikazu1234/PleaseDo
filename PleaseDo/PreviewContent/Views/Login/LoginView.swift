//
//  LoginView.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI

struct LoginView: View {
    @Binding var vm: LoginVM
    enum Field: Hashable {
        case email, pw
    }
    @FocusState private var isKeyboardFocused: Field?
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                LoginTitleView()
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Login")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Text("Please sign in to continue")
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal)
                
                VStack(spacing: 12) {
                    EmailTextField(showIcon: true, placeholder: "user@email.com", text: $vm.email)
                        .shadow(color: .gray, radius: 4, x: 1, y: 2.5)
                        .focused($isKeyboardFocused, equals: .email)
                    
                    PasswordField(showIcon: true, placeholder: "password", text: $vm.pw)
                        .shadow(color: .gray, radius: 4, x: 1, y: 2.5)
                        .focused($isKeyboardFocused, equals: .pw)
                }
                .padding(.horizontal)
                
                HStack {
                    Spacer()
                    
                    LoginButton(title: "Login") {
                        print("Did tap login button")
                    }
                }
                .padding()
            }
            .padding()
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Cancel") {
                        guard let isKeyboardFocused else { return }
                        switch isKeyboardFocused {
                        case .email:
                            vm.email = ""
                        case .pw:
                            vm.pw = ""
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
}

#Preview {
    LoginView(vm: .constant(LoginVM()))
}
