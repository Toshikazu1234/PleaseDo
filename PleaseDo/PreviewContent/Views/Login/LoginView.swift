//
//  LoginView.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import SwiftUI

struct LoginView: View {
    @Binding var vm: LoginVM
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                Spacer()
                
                LoginTitleView()
                
                Text(vm.prompt)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                
                if vm.isLoggingIn {
                    LoginFields(email: $vm.email, pw: $vm.pw)
                } else {
                    SignUpFields(fname: $vm.fname, lname: $vm.lname, email: $vm.newEmail, pw: $vm.newPw)
                }
                
                HStack {
                    Spacer()                    
                    LoginButton(title: vm.prompt) {
                        vm.didTapButton()
                    }
                }
                .padding()
                
                Spacer()
                
                TogglePromptView(isLoggingIn: $vm.isLoggingIn, text: $vm.toggleText, prompt: $vm.toggleButton)
            }
            .padding()
        }
    }
}

#Preview {
    LoginView(vm: .constant(LoginVM()))
}
