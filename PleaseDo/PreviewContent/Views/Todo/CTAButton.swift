//
//  CTAButton.swift
//  PleaseDo
//
//  Created by R K on 3/26/24.
//

import SwiftUI

struct CTAButton: View {
    let title: String
    let color: Color = .blue
    let action: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(color)
            
            Text(title)
                .font(.largeTitle)
                .foregroundStyle(.white)
        }
        .frame(maxHeight: 65)
    }
}

#Preview {
    CTAButton(title: "Confirm") {}
}
