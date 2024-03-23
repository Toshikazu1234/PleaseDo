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
                    TextField("user@email.com", text: $vm.email)
                    
                    SecureField("password", text: $vm.pw)
                }
                .padding(.horizontal)
                
                HStack {
                    Spacer()
                    
                    Button {
                        print("Login tapped")
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .frame(maxWidth: 140, maxHeight: 80)
                                .foregroundStyle(.blue)
                            
                            HStack {
                                Text("Login")
                                    .font(.title)
                                
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 24)
                            }
                            .foregroundStyle(.white)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    LoginView(vm: .constant(LoginVM()))
}
