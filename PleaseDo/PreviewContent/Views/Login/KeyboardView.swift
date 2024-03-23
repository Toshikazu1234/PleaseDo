//
//  KeyboardView.swift
//  PleaseDo
//
//  Created by R K on 3/23/24.
//

import SwiftUI

struct KeyboardView: View {
    let placeholder: String
    @Binding var text: String
    let type: UIKeyboardType
    private var capitalization: TextInputAutocapitalization {
        return switch type {
        case .emailAddress: .never
        default: .words
        }
    }
    
    var body: some View {
        TextField(placeholder, text: $text)
            .textFieldStyle(.roundedBorder)
            .submitLabel(.done)
            .textInputAutocapitalization(capitalization)
            .keyboardType(type)
            .background(Color.clear)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    KeyboardView(placeholder: "test@email.com", text: .constant(""), type: .emailAddress)
        .fixedSize()
        .shadow(color: .gray, radius: 4, x: 1, y: 2.5)
}
