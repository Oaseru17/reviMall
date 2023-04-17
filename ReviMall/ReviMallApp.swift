//
//  ReviMallApp.swift
//  ReviMall
//
//  Created by Precious Osaro on 16/04/2023.
//

import SwiftUI
import CartModule

@main
struct ReviMallApp: App {

    var body: some Scene {
        WindowGroup {
           AppTabView()
                .environmentObject(CartService.shared)
        }
    }
}
