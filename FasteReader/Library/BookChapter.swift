//
//  BookChapter.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/9/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import Foundation

class BookChapter{
    
    static var currentlyReading = "Reading: Dan Brown - Origin Chapter 1"
    
    
    private static var book = BookPrefixes.origin
    private static var chapterNumber = 0
    
    static func setBook(book: BookPrefixes){
        self.book = book
    }
    
    static func setChapterNumber(chapterNumber: Int){
        self.chapterNumber = chapterNumber
    }
}
