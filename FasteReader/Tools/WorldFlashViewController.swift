//
//  WorldFlashViewController.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/16/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import UIKit
// MARK: Properties and Initialization
class WorldFlashViewController: UIViewController {
    
    var wordsPerMinute: Int!
    var book: BookPrefixes!
    var chapterNumber: Int!
    var textToRead = [String]()
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var progressMeter: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Word Flash"
        
        stylizingPlayButton()
        stylizingProgressMeter()
        initialize()
        initialazeText()
        
    }
    
    private func initialize(){
        wordsPerMinute = Profile.sharedInstance.getWordsPerMinute()
        book = BookChapter.getBook()
        chapterNumber = BookChapter.getChapterNumber()
    }
    
}

// MARK: Reading tool protocol
extension WorldFlashViewController: ReadingTool{
    
    func read() {
        
    }
    
    func initialazeText() {
        let textLoader = TextLoader(book: book, chapterNumber: chapterNumber)
        print(textLoader.textFileName)
        
        textToRead = textLoader.loadText()!
        print(textToRead)
    }
    
    
}

// MARK: View controls
extension WorldFlashViewController{
    private func stylizingPlayButton(){
        
        playButton.layer.cornerRadius = 4
        
        let highlightedAttributedString = NSAttributedString(string: "Start", attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
        
        playButton.setAttributedTitle(highlightedAttributedString, for: .highlighted)
        
    }
    
    private func stylizingProgressMeter(){
        progressMeter.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
    }
}



