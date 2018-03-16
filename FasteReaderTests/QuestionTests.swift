//
//  QuestionTests.swift
//  FasteReaderTests
//
//  Created by Goran Pavlovic on 3/16/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import XCTest
@testable import FasteReader

class QuestionTests: XCTestCase {

    func testQuestionText(){
        
        let question = Question(question: "name")
        let text = question.questionText
        
        XCTAssert(text == "name")
        
    }
    
    func testEmptyAnswerArray(){
        
        let question = Question()
        
        let numberOfAnswers = question.answers.count
        
        XCTAssert(numberOfAnswers == 0)
        
    }
    
    func testAddingAnswers(){
        
        let question = Question()
        
        let answer = Answer(answerText: "answer", isCorrect: false)
        
        question.addAnswer(answer: answer)
        
        let numberOfAnswers = question.answers.count
        
        XCTAssert(numberOfAnswers == 1)
        
    }
    
    
}
