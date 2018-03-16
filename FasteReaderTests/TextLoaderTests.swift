//
//  TextLoaderTests.swift
//  FasteReaderTests
//
//  Created by Goran Pavlovic on 3/16/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import XCTest

@testable import FasteReader

class TextLoaderTests: XCTestCase {
    
    func testTextLoaderIsNil(){
        let txtLoader = TextLoader(book: .origin, chapterNumber: 3)
        let txt = txtLoader.loadText()
        
        XCTAssert(txt != nil)
        
    }
    
    func testTextLoadelCount(){
        let txtLoader = TextLoader(book: .origin, chapterNumber: 3)
        let txt = txtLoader.loadText()
        
        XCTAssert(txt?.count == 2066)
    }
    
    func testTextMissing(){
        let txtLoader = TextLoader(book: .origin, chapterNumber: 10)
        let txt = txtLoader.loadText()
        
        XCTAssert(txt == nil)
    }

}
