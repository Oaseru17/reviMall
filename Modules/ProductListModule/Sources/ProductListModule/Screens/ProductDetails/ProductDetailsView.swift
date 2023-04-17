//  ProductDetailsView.swift
//  Created by Precious Osaro on 16/04/2023.

import SwiftUI
import SharedUIModule
import CartModule

struct ProductDetailsView: View {
    
    private enum ViewConfiguration {
        static let cartControlSpacing: CGFloat = 15
    }
    
    @ObservedObject var viewModel: ProductDetailsViewModel
    
    var body: some View {
        
        GeometryReader { reader in
            ZStack {
                ScrollView(.vertical) {
                    VStack {
                        TabView {
                            ForEach(viewModel.state.images, id: \.self) { image in
                                ReviImageView(urlString: image, imageWidth: reader.size.width)
                            }
                        }.frame(width: reader.size.width, height: reader.size.width)
                            .tabViewStyle(.page)
                            .indexViewStyle(.page(backgroundDisplayMode: .always))
                            .accessibilityHidden(true)
                        
                        VStack (alignment: .leading, spacing: ReviUIConfig.Padding.small) {
                            VStack (alignment: .leading, spacing: 0) {
                                Text(viewModel.state.title.capitalized)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                RatingView(rating: Int(viewModel.state.rating.rounded()), label: "(\(viewModel.state.rating))")
                                    .accessibilityElement(children: .ignore)
                                    .accessibilityLabel("Product is rated \(String(format: "%.2f", viewModel.state.rating))")
                            }
                            
                            // Pricing and Cart Control Section
                            HStack {
                                HStack(spacing: ViewConfiguration.cartControlSpacing) {
                                    ReviCartControlButton(icon: "minus") {
                                        viewModel.reduceItemInCart()
                                    }
                                    
                                    Text("\(viewModel.itemCount)")
                                        .font(.subheadline).bold()
                                    
                                    ReviCartControlButton(icon: "plus") {
                                        viewModel.increaseItemInCart()
                                    }
                                }.accessibilityElement(children: .ignore)
                                .accessibilityLabel("Number of items to add to cart")
                                .accessibilityValue(String(viewModel.itemCount))
                                .accessibilityAdjustableAction { direction in
                                    switch direction {
                                    case .increment:
                                        viewModel.increaseItemInCart()
                                    case .decrement:
                                        viewModel.reduceItemInCart()
                                    default:
                                       print("Unknown")
                                    }
                                }
                                
                                Spacer()
                                VStack (alignment: .trailing) {
                                    Text("\(viewModel.state.formattedPrice)").font(.title2)
                                        .bold()
                                        .foregroundColor(Color.black)
                                        .accessibilityLabel("Discount price \(viewModel.state.formattedPrice)")
                                    
                                    Text("\(viewModel.state.price.formatted(.currency(code: "USD")))")
                                        .font(.subheadline)
                                        .strikethrough()
                                        .foregroundColor(.red)
                                        .accessibilityLabel("Original price \(viewModel.state.price.formatted(.currency(code: "USD")))")
                                }.accessibilityElement(children: .combine)
                            }
                            
                            // Additional Descriptiion
                            VStack (alignment: .leading, spacing: 0) {
                                Text("DESCRIPTION")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                
                                Text(viewModel.state.description)
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                            }.accessibilityElement(children: .combine)
                            
                            HStack {
                                Text("BRAND:")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                
                                Text(viewModel.state.brand.capitalized)
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                            }.accessibilityElement(children: .combine)
                            
                            HStack {
                                Text("CATEGORY:")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                
                                Text(viewModel.state.category.capitalized)
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                            }.accessibilityElement(children: .combine)
                            
                        }.padding(ReviUIConfig.Padding.medium)
                    }
                    .alert(isPresented: $viewModel.showQuantityReach) {
                        Alert(title: Text("Stock limit reached"),
                              message: Text("We are sorry, either you have reached the maximum number of available stock or the product is out of stock"), dismissButton: .default(Text("OK")))
                    }
                    .toolbar(.hidden, for: .tabBar)
                    .toolbar {
                        NavigationLink {
                            CartViewBuilder.start()
                        } label: {
                            ReviCartView(cartItem: viewModel.cartItemCount)
                                .accessibilityAddTraits(.isButton)
                                .accessibilityIdentifier("cartViewButton")
                        }
                    }
                }.edgesIgnoringSafeArea(.all)
            }.overlay(alignment: .bottom) {
                
                Button {
                    viewModel.addProduct(quantity: viewModel.itemCount)
                } label: {
                    HStack {
                        Spacer()
                        Image(systemName: "cart.fill.badge.plus")
                            .font(.system(size: ReviUIConfig.Button.fontSize))
                        
                        Text("ADD TO CART")
                            .font(.system(size: ReviUIConfig.Button.fontSize))
                            .bold()
                        
                        if viewModel.canShowCartItemCount {
                            Text("- ^[\(viewModel.itemCount) Item](inflect: true)")
                                .font(.system(size: ReviUIConfig.Button.fontSize))
                                .fontWeight(.heavy)
                                .foregroundColor(.green)
                        }
                        Spacer()
                    }
                }.buttonStyle(ReviDefaultButtonStyle())
                    .padding([.leading, .trailing], ReviUIConfig.Padding.medium)
                    .accessibilityIdentifier("addToCartButton")
                
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(viewModel: ProductDetailsViewModel(model: ProductListModuleMockHelper.getProduct()))
    }
}
