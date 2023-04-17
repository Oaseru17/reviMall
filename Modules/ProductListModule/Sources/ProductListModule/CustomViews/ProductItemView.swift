//  ProductItemView.swift
//  Created by Precious Osaro on 16/04/2023.

import Foundation
import SwiftUI
import SharedUIModule
import CartModule

struct ProductItemView: View {
    
    private enum ViewConfiguration {
        enum AddToCartView {
            static let padding: CGFloat = 18
            static let width: CGFloat = 50
            static let labelOffSet: CGFloat = -5
        }
    }
    
    private let defaultAddedProduct = 1
    let model: Product
    let imageWidth: CGFloat
    
    @EnvironmentObject var cartService: CartService
    
    var body: some View {
            ZStack (alignment: .leading) {
                Color("ProductItemBackground")
                VStack(alignment: .leading) {
                    ReviImageView(urlString: model.thumbnail, imageWidth: imageWidth)
                    
                    VStack(alignment: .leading) {
                        Text(model.title.capitalized)
                            .font(.subheadline)
                            .lineLimit(1)
                            .foregroundColor(.black)
                            .frame(maxWidth: imageWidth - ReviUIConfig.Padding.small, alignment: .leading)
                        Text(model.brand)
                            .font(.footnote)
                            .foregroundColor(.gray)
                        
                        VStack (alignment: .leading) {
                            Text("\(model.price.formatted(.currency(code: "USD")))")
                                .font(.subheadline)
                                .strikethrough()
                                .foregroundColor(.red)
                            Text("\(model.formattedPrice)")
                                .bold()
                                .foregroundColor(Color.black)
                        }.padding(.top, 1)
                        RatingView(rating: Int(model.rating.rounded()), label: "(\(model.rating))")
                    }.padding([.leading, .trailing, .bottom], ReviUIConfig.Padding.small)
                }
            }.overlay(
                Button {
                    addProductToCart()
                } label: {
                    VStack {
                        Image(systemName: "plus")
                            .resizable()
                            .offset(x: ViewConfiguration.AddToCartView.labelOffSet, y: ViewConfiguration.AddToCartView.labelOffSet)
                    }.padding(ViewConfiguration.AddToCartView.padding)
                        .frame(width: ViewConfiguration.AddToCartView.width, height: ViewConfiguration.AddToCartView.width)
                        .background(Color("PrimaryGreen"))
                        .clipShape(RoundedRectangle(cornerRadius: ReviUIConfig.Radius.small))
                        .foregroundColor(.white).offset(x: ReviUIConfig.Padding.small, y: ReviUIConfig.Padding.small)
                }
                , alignment: .bottomTrailing)
        }
    
    func addProductToCart() {
        cartService.addProduct(product: model, quantity: defaultAddedProduct )
    }
}

struct ProductItemView_Previews: PreviewProvider {
    static var previews: some View {
        ProductItemView(model: ProductListModuleMockHelper.getProduct(), imageWidth: CGFloat(integerLiteral: 174))
    }
}
