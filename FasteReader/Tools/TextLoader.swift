//
//  TextLoader.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/16/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import Foundation
import UIKit

class TextLoader{
    
    var textFileName: String
    
    init(book: BookPrefixes, chapterNumber: Int){
        
        textFileName = "\(book.rawValue)_chapter_\(chapterNumber)"
        
    }
    
    public func loadText() -> [String]?{
        
        if let file = Bundle.main.path(forResource: textFileName, ofType: "txt"){
            if let text = try? String(contentsOfFile: file){
                var allWords = text.components(separatedBy: CharacterSet.alphanumerics.inverted)
                allWords = allWords.filter{ $0 != ""}
                
                return allWords
            }
        }
        
        return nil
    }

}
