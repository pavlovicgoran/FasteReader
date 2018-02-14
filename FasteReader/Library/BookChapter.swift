//
//  BookChapter.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/9/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import Foundation

class BookChapter{

    private static let keyChapter = "CURRENT_CHAPTER"
    
    static var currentlyReading = "Reading: Dan Brown - Origin Chapter 1"
    
    private static var book = BookPrefixes.origin
    private static var chapterNumber = 1
    
    
}
// MARK: Saving and restoring state using UserDefaults
extension BookChapter{
    
    static func saveCurrentChapter(){
        let defaults = UserDefaults.standard
        defaults.set(currentlyReading, forKey: keyChapter)
    }
    
    static func restoreCurrentChapter(){
        let defaults = UserDefaults.standard
        if let chapter = defaults.string(forKey: keyChapter){
            currentlyReading = chapter
            setBookFromCurrentlyReading()
            chapterNumber = Int(currentlyReading.digitsOnly())!
        }else{
            currentlyReading = "Reading: Dan Brown - Origin Chapter 1"
            book = .origin
            chapterNumber = 1
        }
    }
    
}

// MARK: Getters and Setters
extension BookChapter{
    static func setBook(book: BookPrefixes){
        self.book = book
    }
    
    static func setChapterNumber(chapterNumber: Int){
        self.chapterNumber = chapterNumber
    }
    
    static func setBookFromCurrentlyReading(){
        if currentlyReading.contains(availableBookTitles.madeToStick.rawValue){
            book = .madeToStick
            return
        }
        if currentlyReading.contains(availableBookTitles.artOfLearning.rawValue){
            book = .artOfLearning
            return
        }
        if currentlyReading.contains(availableBookTitles.creativity.rawValue){
            book = .creativity
            return
        }
        if currentlyReading.contains(availableBookTitles.origin.rawValue){
            book = .origin
            return
        }
        if currentlyReading.contains(availableBookTitles.pieceOfMind.rawValue){
            book = .pieceOfMind
            return
        }
        if currentlyReading.contains(availableBookTitles.quantumTheory.rawValue){
            book = .quantumTheory
            return
        }
        if currentlyReading.contains(availableBookTitles.spy.rawValue){
            book = .spy
            return
        }
    }
}









