//
//  TitledTextField.swift
//  PleaseDo
//
//  Created by R K on 3/24/24.
//

import SwiftUI

struct TitledTextField: View {
    let title: String
    @Binding var text: String
    let placeholder: String
    let didChange: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(title):")
                .font(.caption2)
                .foregroundStyle(.secondary)
            
            TextField(placeholder, text: $text, axis: .vertical)
                .onChange(of: text, didChange)
        }
    }
}

#Preview {
    TitledTextField(title: "Title", text: .constant(""), placeholder: "Type something here") {}
}
