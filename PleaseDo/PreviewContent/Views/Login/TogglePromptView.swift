//
//  TogglePromptView.swift
//  PleaseDo
//
//  Created by R K on 3/23/24.
//

import SwiftUI

struct TogglePromptView: View {
    @Binding var isLoggingIn: Bool
    @Binding var text: String
    @Binding var prompt: String
    
    var body: some View {
        HStack() {
            Spacer()
            Text(text)
            
            Button(prompt) {
                isLoggingIn.toggle()
            }
            Spacer()
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TogglePromptView(isLoggingIn: .constant(true), text: .constant("Don't have an account?"), prompt: .constant("Sign up here"))
}
