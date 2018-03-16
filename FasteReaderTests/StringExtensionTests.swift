//
//  StringExtensionTests.swift
//  FasteReaderTests
//
//  Created by Goran Pavlovic on 3/16/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import XCTest
@testable import FasteReader

class StringExtensionTests: XCTestCase {

    func testNumberInString(){
        let string = "99999"
        let numberString = string.digitsOnly()
        let number = Int(numberString)
        
        XCTAssert(number == 99999)
    }
    
    func testAllLetters(){
        let string = "a#a#a"
        let numberString = string.digitsOnly()
        let number = Int(numberString)
        
        XCTAssert(number == nil)
    }
    
    func testMixedDecimalsLetters(){
        
        let string = "199a945"
        let numberString = string.digitsOnly()
        let number = Int(numberString)
        
        XCTAssert(number == 199945)
        
    }
    
    func testEmptyString(){
        let string = ""
        
        let numberString = string.digitsOnly()
        let number = Int(numberString)
        
        XCTAssert(number == nil)
    }
    
    func testNegativeString(){
        //Function is used only on positive numbers
        let string = "-1"
        
        let numberString = string.digitsOnly()
        let number = Int(numberString)
        
        XCTAssert(number == 1)
        
    }
    
}
