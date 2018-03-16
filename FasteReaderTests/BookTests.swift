//
//  BookTests.swift
//  FasteReaderTests
//
//  Created by Goran Pavlovic on 3/16/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import XCTest
@testable import FasteReader

class BookTests: XCTestCase {

    
    func testBookRawPrefix(){
        let book = Book(author: "Chip Heath", title: "Made to Stick", prefix: .madeToStick)
        
        let rawPrefix = book.getPrefixRawValue()
        
        XCTAssert(rawPrefix == "stick")
    }
    
    func testBookPrefix(){
        let book = Book(author: "Dan Brown", title: "Origin", prefix: .origin)
        
        let prefix = book.getPrefix()
        
        XCTAssert(prefix == .origin)
    }
    
    func testBookAuthor(){
        let book = Book(author: "Author", title: "Title", prefix: .artOfLearning)
        
        let name = book.getAuthor()
        
        XCTAssert(name == "Author")
    }
    
    func testBookTitle(){
        let book = Book(author: "Author", title: "Title", prefix: .origin)
        let title = book.getTitle()
        
        XCTAssert(title == "Title")
    }
    
}
