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
    
    public func getPrefix() -> String{
        return prefixForBookFile.rawValue
    }
    
}
