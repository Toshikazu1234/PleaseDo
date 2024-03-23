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
                HStack {
                    Image("PleaseDoLogo")
                        .resizable()
                        .scaledToFit()
                    
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
                
                VStack(alignment: .leading, spacing: 1) {
                    Text("Login")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Text("Please sign in to continue")
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal)
                
                VStack(spacing: 5) {
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
                    
                    Button {
                        print("Login tapped")
                    } label: {
                        HStack {
                            Text("Login")
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
