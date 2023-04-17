//  ReviDefaultButtonStyle.swift
//  Created by Precious Osaro on 16/04/2023.

import SwiftUI

public struct ReviDefaultButtonStyle: ButtonStyle {
    
    private enum ViewConfiguration {
        static let buttonCornerRadius: CGFloat = 10
    }
    
    public init() { }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(ViewConfiguration.buttonCornerRadius)
    }
}
