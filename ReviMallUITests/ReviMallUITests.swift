//
//  ReviMallUITests.swift
//  ReviMallUITests
//
//  Created by Precious Osaro on 16/04/2023.
//

import XCTest

final class ReviMallUITests: XCTestCase {
    let app = XCUIApplication()
    let defaultWaitingTime = TimeInterval(2)
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["isRunningUITests"]
        app.launch()
    }
    
    func testProductSelectionToCheckOut() throws {
        // Open product list view
        let productCard = app.staticTexts["Handcraft"]
        XCTAssertTrue(productCard.waitForExistence(timeout:defaultWaitingTime))
        productCard.tap()
        
        // Increase quantity of items to be added to cart
        let plusCartControl = app.buttons["plus_CartControlButton"]
        XCTAssertTrue(plusCartControl.waitForExistence(timeout:defaultWaitingTime))
        plusCartControl.tap()
        plusCartControl.tap()
        
        // Add items to cart
        let addToCartButton = app.buttons["addToCartButton"]
        XCTAssertTrue(addToCartButton.waitForExistence(timeout:defaultWaitingTime))
        addToCartButton.tap()
        
        // Open cart view
        let cartButton = app.buttons["cartViewButton"].firstMatch
        XCTAssertTrue(cartButton.waitForExistence(timeout:defaultWaitingTime))
        cartButton.tap()
        
        // Check for item
        let cartItemTitleLabel = app.staticTexts["cartItemTitleLabel"].firstMatch
        XCTAssertTrue(cartItemTitleLabel.waitForExistence(timeout:defaultWaitingTime))
        XCTAssertEqual(cartItemTitleLabel.label, "Handcraft")
        
        // Check items added to cart
        let cartItemQuantityLabel = app.staticTexts["cartItemQuantityLabel"].firstMatch
        XCTAssertTrue(cartItemQuantityLabel.waitForExistence(timeout:defaultWaitingTime))
        XCTAssertEqual(cartItemQuantityLabel.label, "3")
        
        // Perform check out
        let checkOutButton = app.buttons["checkOutButton"]
        XCTAssertTrue(checkOutButton.waitForExistence(timeout:defaultWaitingTime))
        checkOutButton.tap()
        
        // Success label
        let searchText = "Check Out Successful"
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", searchText)
        let successLabel = app.staticTexts.containing(predicate).firstMatch
        
        XCTAssertTrue(successLabel.waitForExistence(timeout:defaultWaitingTime))
    }
    
    func testProductSelectionToExceedingStock() throws {
        
        // Open product list view
        let productCard = app.staticTexts["Handcraft"]
        XCTAssertTrue(productCard.waitForExistence(timeout:defaultWaitingTime))
        productCard.tap()
        
        // Increase quantity of items to be added to cart
        let plusCartControl = app.buttons["plus_CartControlButton"]
        XCTAssertTrue(plusCartControl.waitForExistence(timeout:defaultWaitingTime))
        plusCartControl.tap()
        plusCartControl.tap()
        plusCartControl.tap()
        
        // Add items to cart
        let addToCartButton = app.buttons["addToCartButton"]
        XCTAssertTrue(addToCartButton.waitForExistence(timeout:defaultWaitingTime))
        addToCartButton.tap()
        
        // Trigger exceeding stock
        addToCartButton.tap()
        
        // Error label
        let searchText = "Stock limit reached"
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", searchText)
        let messageLabel = app.staticTexts.containing(predicate).firstMatch
        
        XCTAssertTrue(messageLabel.waitForExistence(timeout:defaultWaitingTime))
    }
}
