//  ReviImageView.swift
//  Created by Precious Osaro on 16/04/2023.

import Foundation
import SwiftUI

public struct ReviImageView: View {
    
    public var urlString: String
    public let imageWidth: CGFloat
    
    public init(urlString: String, imageWidth: CGFloat) {
        self.urlString = urlString
        self.imageWidth = imageWidth
    }
    
    public var body: some View {
        AsyncImage(url: URL(string: urlString)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageWidth, height: imageWidth)
                    .clipped()
            } else if phase.error != nil {
                Image(systemName: "photo.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageWidth, height: imageWidth)
                    .clipped()
            } else {
                ProgressView()
                    .frame(width: imageWidth, height: imageWidth)
            }
        }
    }
}
