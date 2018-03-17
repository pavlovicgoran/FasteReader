//
//  FasteReaderUITests.swift
//  FasteReaderUITests
//
//  Created by Goran Pavlovic on 2/2/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import XCTest

class FasteReaderUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExpandVisionTool() {
        
        let app = XCUIApplication()
        
        XCTAssert(app.buttons["memory"].exists)
        
  
        app.buttons["memory"].tap()
        
        XCTAssert(app.staticTexts["Expand Vision"].exists)
        
        
    }
    
}
