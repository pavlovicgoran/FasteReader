//
//  Answer.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/27/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import Foundation

class Answer{
    
    var answerText: String
    var isCorrect: Bool
    
    var description: String{
        return "answerText: \(answerText), isCorrect: \(isCorrect) \n"
    }
    
    init(answerText: String, isCorrect: Bool) {
        self.answerText = answerText
        self.isCorrect = isCorrect
    }
    
    init(stringToParse: String) {
        //separate at =
        let answer = stringToParse.components(separatedBy: "=")
        answerText = answer[0]

        isCorrect = answer[1].contains("T")
    }
    
    
    
}
