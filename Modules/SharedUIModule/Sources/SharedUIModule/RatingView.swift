//  RatingView.swift
//  Created by Precious Osaro on 16/04/2023.

import SwiftUI
import Foundation

public struct RatingView: View {
    
    var rating: Int = 5
    var label = ""
    var maximumRating = 5
    var offImage: Image? = nil
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    
    public init(rating: Int, label: String = "") {
        self.rating = rating
        self.label = label
    }
    
    public var body: some View {
        HStack (spacing: 1) {
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .resizable()
                    .foregroundColor(number > rating ? offColor : onColor)
                    .frame(width: 12, height: 12)
            }
            if !label.isEmpty {
                Text(label)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 4)
    }
}
