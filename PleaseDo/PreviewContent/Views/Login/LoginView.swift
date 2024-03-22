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
        Text("Login")
    }
}

#Preview {
    LoginView(vm: .constant(LoginVM()))
}
