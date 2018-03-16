//
//  AnswerTests.swift
//  FasteReaderTests
//
//  Created by Goran Pavlovic on 3/16/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import XCTest
@testable import FasteReader

class AnswerTests: XCTestCase {
    
    func testAnswerText(){
        
        let answer = Answer(answerText: "text", isCorrect: false)
        
        let answerText = answer.answerText;
        
        XCTAssert(answerText == "text")
        
    }
    
    func testIsCorrect(){
        let answer = Answer(answerText: "text", isCorrect: true)
        
        
        XCTAssert(answer.isCorrect)
    }

}
