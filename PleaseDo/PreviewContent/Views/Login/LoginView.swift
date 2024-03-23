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
        }
    }
}

#Preview {
    LoginView(vm: .constant(LoginVM()))
}
