//  BaseCoordinatorProtocol.swift
//  Created by Precious Osaro on 16/04/2023.

import Foundation
import SwiftUI

public protocol BaseViewBuilderProtocol {
    
    associatedtype BaseView: View

    @ViewBuilder
    func start() -> Self.BaseView
}
