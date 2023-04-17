//  CaryDetailView.swift
//  Created by Precious Osaro on 16.04.23.

import SwiftUI
import SharedUIModule

struct CartDetailView: View {
    
    private enum ViewConfiguration {
        static let cartImageWidth: CGFloat = 80
        static let cartDeleteIconSize: CGFloat = 12
    }
    
    @ObservedObject var viewModel: CartDetailViewModel
    @EnvironmentObject var cartService: CartService
    
    var body: some View {
        VStack {
            
            // Empty Cart
            if viewModel.showEmptyCart {
                Text("No Item in yourCart")
            }
            
            // Cart List
            List {
                ForEach(viewModel.items) { item in
                    HStack {
                        ReviImageView(urlString: item.product.thumbnail, imageWidth: ViewConfiguration.cartImageWidth)
                        
                        VStack (spacing: ReviUIConfig.ViewSpacing.small) {
                            HStack(alignment: .top) {
                                VStack(alignment: .leading) {
                                    Text(item.product.title)
                                        .font(.caption)
                                        .accessibilityIdentifier("cartItemTitleLabel")
                                    HStack {
                                        Text("BRAND:")
                                            .font(.caption2)
                                            .fontWeight(.bold)
                                        
                                        Text(item.product.brand)
                                            .font(.caption)
                                            .foregroundColor(Color.gray)
                                    }
                                }
                                
                                Spacer()
                                
                                Button {
                                    cartService.removeItem(item)
                                } label: {
                                    Image(systemName: "trash.fill")
                                        .foregroundColor(.red)
                                        .font(.system(size: ViewConfiguration.cartDeleteIconSize))
                                }
                            }
                            
                            HStack(alignment: .bottom) {
                                HStack(spacing: ReviUIConfig.ViewSpacing.small) {
                                    ReviCartControlButton(icon: "minus") {
                                        cartService.decreaseItemQuantity(item)
                                    }
                                    
                                    Text("\(item.quantity)")
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(.black)
                                        .accessibilityIdentifier("cartItemQuantityLabel")
                                    
                                    ReviCartControlButton(icon: "plus") {
                                        cartService.increaseItemQuantity(item)
                                    }
                                    
                                }.layoutPriority(1)
                                Spacer()
                                VStack {
                                    Text(item.formattedTotal)
                                        .font(.subheadline)
                                        .bold()
                                }
                            }
                        }
                    }.background(.white)
                        .buttonStyle(PlainButtonStyle())
                }
            }
            
            // Summary
            if !viewModel.showEmptyCart {
                VStack {
                    HStack {
                        Text("Total:")
                        Spacer()
                        Text(cartService.cartTotal)
                            .bold()
                    }
                    
                    Button {
                        viewModel.checkOutAlert.toggle()
                    } label: {
                        HStack {
                            Spacer()
                            Image(systemName: "cart.fill")
                                .font(.system(size: ReviUIConfig.Button.fontSize))
                            
                            Text("CHECK OUT")
                                .font(.system(size: ReviUIConfig.Button.fontSize))
                                .bold()
                            
                            Spacer()
                        }
                    }.buttonStyle(ReviDefaultButtonStyle())
                        .accessibilityIdentifier("checkOutButton")
                    .alert(isPresented: $viewModel.checkOutAlert) {
                        let button = Alert.Button.default(Text("OK")) {
                            viewModel.checkOut()
                        }
                        return Alert(title: Text("Check Out Successful"), message: Text("All the products in your cart have been ordered successfully"), dismissButton: button)
                    }
                }.padding([.trailing, .leading], ReviUIConfig.Padding.medium)
            }
        } .toolbar(.hidden, for: .tabBar)
            .navigationBarTitle("My Cart")
    }
}

struct CartDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CartDetailView(viewModel: CartDetailViewModel())
    }
}
