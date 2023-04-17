//  ReviCartView.swift
//  Created by Precious Osaro on 16/04/2023.

import SwiftUI

public struct ReviCartView: View {
    
    enum ViewConfiguration {
        static let countViewPadding: CGFloat = 4
        static let countViewOffSet: CGFloat = 10
    }
    
    private var cartItem = 0
    
    public init(cartItem: Int) {
        self.cartItem = cartItem
    }
    
    public var body: some View {
        ZStack {
            Image(systemName: "cart.fill")
                .foregroundColor(.black)
            
            if cartItem > 0 {
                Text("\(cartItem)")
                    .font(.caption2)
                    .fontWeight(.heavy)
                    .padding(ViewConfiguration.countViewPadding)
                    .foregroundColor(.white)
                    .background(Color("PrimaryGreen"))
                    .clipShape(Circle())
                    .offset(x: ViewConfiguration.countViewOffSet, y: -ViewConfiguration.countViewOffSet)
                    .accessibilityIdentifier("cartViewQuantityLabel")
            }
        }
    }
}
