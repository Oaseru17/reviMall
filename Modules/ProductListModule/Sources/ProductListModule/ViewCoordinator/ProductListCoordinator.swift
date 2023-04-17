//  ProductListCoordinator.swift
//  Created by Precious Osaro on 16/04/2023.

import SwiftUI
import CoreModule
import NetworkingModule

public class ProductListViewBuilder: BaseViewBuilderProtocol {

    public init() {}
    
    @MainActor public func start() -> some View {
        ProductListView(viewModel: ProductListViewModel(apiClient: ProductListAPIService()))
    }
}
