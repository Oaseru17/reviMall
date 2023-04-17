//  TabView.swift
//  Created by Precious Osaro on 16/04/2023.

import Foundation
import SwiftUI
import ProductListModule
import AboutDevModule

struct AppTabView: View {
    
    private let mallBuilder = ProductListViewBuilder()
    private let aboutBuilder = AboutViewBuilder()
    
    var body: some View {
        TabView {
            mallBuilder.start()
                .tabItem {
                    Label("Mall", systemImage: "square.grid.2x2.fill")
                }
            aboutBuilder.start()
                .tabItem {
                    Label("About Dev", systemImage: "person.crop.square")
                }
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
