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
    
    private var wordsPerMinute: Int!
    private var book: BookPrefixes!
    private var chapterNumber: Int!
    private var textToRead = [String]()
    private var timer = Timer()
    private let totalTime = 60
    private var passedTime = 0
    
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
    
    @IBAction func play(_ sender: UIButton) {
        play()
    }
    
}
// MARK: START READING
extension WorldFlashViewController{
    
    private func play(){
        hideNavBar()
        toggleButton()
        startTimer()
    }
    
    private func hideNavBar(){
       navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func showNavBar(){
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func toggleButton(){
        playButton.isEnabled = !playButton.isEnabled
    }
    
    private func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProgressMeter), userInfo: nil, repeats: true)
    }
    
    @objc func updateProgressMeter(){
        passedTime += 1
        let completed = Float(passedTime) / Float(totalTime)
        progressMeter.setProgress(completed, animated: true)
        timeExpired()
    }
    
    private func timeExpired(){
        if passedTime >= totalTime{
            timer.invalidate()
            reset()
            toggleButton()
            showNavBar()
        }
    }
    
    private func reset(){
        passedTime = 0
        progressMeter.progress = 0.0
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
        
        let highlightedAttributedString = NSAttributedString(string: "START READING", attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
        
        playButton.setAttributedTitle(highlightedAttributedString, for: .highlighted)
        
        let disabledAttributedString = NSAttributedString(string: "READING...", attributes:
            [NSAttributedStringKey.foregroundColor : UIColor.white])
        playButton.setAttributedTitle(disabledAttributedString, for: .disabled)
        playButton.setBackgroundColor(color: .red, forState: .disabled)
        
    }
    
    private func stylizingProgressMeter(){
        progressMeter.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        progressMeter.progress = 0.0
    }
}










