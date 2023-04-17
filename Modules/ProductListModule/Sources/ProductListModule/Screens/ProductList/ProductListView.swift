//  ProductListView.swift
//  Created by Precious Osaro on 02/12/2022.

import SwiftUI
import SharedUIModule
import CoreModule
import CartModule

public struct ProductListView: View {
    
    private enum ViewConfiguration {
        static let loadingTopMargin: CGFloat = 100
        static let screenPadding: CGFloat = 18
    }
    
    private let gridItemLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    @ObservedObject var viewModel: ProductListViewModel
    @EnvironmentObject var cartService: CartService
    
    public let fetchingProductView = {
        VStack {
            Spacer(minLength: ViewConfiguration.loadingTopMargin)
            ProgressView()
            Text("Fetching Product.")
                .bold()
            Spacer()
        }
    }()
    
    public let fetchingMoreView = {
        HStack(spacing: ReviUIConfig.ViewSpacing.small) {
            Spacer()
            ProgressView()
            Text("Fetching More Product.")
                .bold()
            Spacer()
        }
    }()
}

extension ProductListView {
    public var body: some View {
        GeometryReader { geo in
            NavigationStack() {
                ScrollView(.vertical) {
                    if viewModel.isLoading {
                        fetchingProductView
                    } else {
                        LazyVGrid(columns: gridItemLayout, spacing: ReviUIConfig.ViewSpacing.small) {
                            ForEach(viewModel.productList) { product in
                                NavigationLink {
                                    ProductDetailsView(viewModel: ProductDetailsViewModel(model: product))
                                } label: {
                                    ProductItemView(model: product, imageWidth: (geo.size.width * 0.5) - ViewConfiguration .screenPadding)
                                        .cornerRadius(ReviUIConfig.Radius.small)
                                        .clipped()
                                        .onAppear {
                                            Task {
                                                await viewModel.fetchMoreIfAvailable(currentProduct: product)
                                            }
                                        }
                                }
                            }
                        }.padding(ReviUIConfig.Padding.small)
                        
                        if viewModel.loadingMore {
                            fetchingMoreView
                                .padding(ReviUIConfig.Padding.small)
                        }
                        
                    }
                }.navigationBarTitle("ReviMall")
                    .toolbar {
                        NavigationLink {
                            CartViewBuilder.start()
                        } label: {
                            ReviCartView(cartItem: viewModel.cartItemCount)
                        }
                    }
                    .toolbar(.visible, for: .tabBar)
                    .onAppear {
                        Task {
                            await viewModel.fetchProducts()
                        }
                    }.alert(isPresented: $viewModel.hasError) { () -> Alert in
                        Alert(title: Text(viewModel.errorMessage))
                    }
            }
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(viewModel: MockProductListViewModel(apiClient: MockAPIService()))
    }
}
