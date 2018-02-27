//
//  Question.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/27/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import Foundation

class Question{
    
    var questionText: String
    var answers = [Answer]()
    
    var description: String{
        var string  = "questionText: \(questionText)\n"
        for answer in answers{
            string += answer.description
        }
        return string
    }
    
    init() {
        questionText = ""
    }
    
    init(question: String) {
        questionText = question
    }
    
    public func addAnswer(answer: Answer){
        answers.append(answer)
    }
    
    public func setQuestionText(text: String){
        questionText = text
    }
    
}
