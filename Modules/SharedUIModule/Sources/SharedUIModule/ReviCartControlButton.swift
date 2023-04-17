//  ReviCartControlButton.swift
//  Created by Precious Osaro on 16/04/2023.

import SwiftUI

public struct ReviCartControlButton: View {
   
    var icon: String
    var action: (()->())?
    
    public init(icon: String, action: (() -> ())? = nil) {
        self.icon = icon
        self.action = action
    }
    
    public var body: some View {
        Button {
            action?()
        } label: {
            Image(systemName: icon)
                .fontWeight(.bold)
                .padding(18)
                .frame(width: 45, height: 45)
                .background(Color.white)
                .clipShape(Circle())
                .foregroundColor(.black)
                .shadow(color: .gray.opacity(0.3), radius: 3)
        }.accessibilityIdentifier("\(icon)_CartControlButton")
    }
}
