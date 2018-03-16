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
    //Parse takes strings in special format
    func testParseText(){
        let answer = Answer(stringToParse: "abcd = T")
        let answerText = answer.answerText
        
        XCTAssert(answerText == "abcd ")
    }
    
    func testParseIsCorrect(){
        let answer = Answer(stringToParse: "abcd = T")
        
        
        XCTAssert(answer.isCorrect)
    }
    
    func testNotCorrect(){
        let answer = Answer(stringToParse: "asdfjn = F")
        
        XCTAssert(!answer.isCorrect)
        
    }
    

}
