//
//  Book.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/6/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import Foundation

enum BookPrefixes: String{
    case madeToStick = "stick"
    case origin = "origin"
    case creativity = "create"
    case spy = "spy"
    case artOfLearning = "learning"
    case quantumTheory = "theory"
    case pieceOfMind = "mind"
}

enum availableBookTitles: String{
    case madeToStick = "Chip Heath - Made To Stick"
    case origin = "Dan Brown - Origin"
    case creativity = "Ed Catmul - Creativity Inc"
    case spy = "Janson Hanson - Spy Secrets"
    case artOfLearning = "Josh Waitzkin - The Art Of Learning"
    case quantumTheory = "Marcus Chown - Quantum Theory"
    case pieceOfMind = "Seneca - Piece of Mind"
}

class Book{
    
    private var author: String
    private var title: String
    private var prefixForBookFile: BookPrefixes
    
    init(author: String, title: String, prefix: BookPrefixes) {
        
        self.author = author
        self.title = title
        self.prefixForBookFile = prefix
    }
    
    public func getAuthor() -> String{
        return author
    }
    
    public func getTitle() -> String{
        return title
    }
    
    public func getPrefixRawValue() -> String{
        return prefixForBookFile.rawValue
    }
    
    public func getPrefix() -> BookPrefixes{
        return prefixForBookFile
    }
    
}
