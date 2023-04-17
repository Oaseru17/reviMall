//  CartModuleCoordinator.swift
//  Created by Precious Osaro on 16/04/2023.

import SwiftUI
import CoreModule

public enum CartViewBuilder {
    public static func start() -> some View {
        CartDetailView(viewModel: CartDetailViewModel(cartService: CartService.shared))
    }
}
