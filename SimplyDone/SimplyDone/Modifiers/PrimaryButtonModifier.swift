//
//  PrimaryButtonModifier.swift
//  SimplyDone
//
//  Created by Ramazan Abdullayev on 03/03/2025.
//

import SwiftUI

struct PrimaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.green.opacity(0.8))
            .foregroundColor(.black)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.clear, lineWidth: 0.5)
            )
    }
}
