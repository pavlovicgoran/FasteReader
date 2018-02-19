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
    
    private let MIN_TO_SEC = 60.0
    private let SEC_TO_MILSEC = 1000.0
    
    private var wordsPerMinute: Int!
    private var book: BookPrefixes!
    private var chapterNumber: Int!
    private var textToRead = [String]()
    
    private var timerProgress = Timer()
    private var timerReading = Timer()
    
    private let totalTime = 60
    private var passedTime = 0
    private var wordIndex = 0
    
    private var delay = 0.0
    
    private let toolStyle = ToolStyle()
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var progressMeter: UIProgressView!
    @IBOutlet weak var showLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Word Flash"
        
        toolStyle.playButtonStyle(for: playButton)
        toolStyle.progressMeterStyle(for: progressMeter)
        initialize()
        initialazeText()
        
    }
    
    private func initialize(){
        wordsPerMinute = Profile.sharedInstance.getWordsPerMinute()
        book = BookChapter.getBook()
        chapterNumber = BookChapter.getChapterNumber()
        
        delay = (SEC_TO_MILSEC / (Double(wordsPerMinute) / (MIN_TO_SEC))) * 0.001
    }
    
    @IBAction func play(_ sender: UIButton) {
        play()
    }
    
}
// MARK: START READING
extension WorldFlashViewController{
    
    private func play(){
        
        toolStyle.hidingNavBar(navigationController: navigationController!)
        toggleButton()
        startTimer()
        read()
    }
    
    
    private func toggleButton(){
        playButton.isEnabled = !playButton.isEnabled
    }
    
    private func startTimer(){
        timerProgress = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProgressMeter), userInfo: nil, repeats: true)
    }
    
    @objc func updateProgressMeter(){
        passedTime += 1
        let completed = Float(passedTime) / Float(totalTime)
        progressMeter.setProgress(completed, animated: true)
        timeExpired()
    }
    
    private func timeExpired(){
        if passedTime >= totalTime{
            
            reset()
        }
    }
    
    private func reset(){
        timerProgress.invalidate()
        timerReading.invalidate()
        
        setOverLabel()
        returnToTechniquesView()
    }
    
    private func setOverLabel(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){[unowned self] in
            self.showLabel.text = "Congratulations \n Choose another text to read"
        }
        
    }
    
    private func returnToTechniquesView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){[unowned self] in
            
                self.toolStyle.showingNavBar(navigationController: self.navigationController!)
                self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: Reading tool protocol
extension WorldFlashViewController: ReadingTool{
    
    func read() {
        
        timerReading = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(showingWords), userInfo: nil, repeats: true)
        print(delay)
    }
    
    @objc func showingWords(){
       
        guard wordIndex < textToRead.count else {
            print("Reading over")
            reset()
            return
        }
        
        let wordToShow = textToRead[wordIndex]
        wordIndex += 1
        showLabel.text = wordToShow
        
    }
    
    
    func initialazeText() {
        let textLoader = TextLoader(book: book, chapterNumber: chapterNumber)
        textToRead = textLoader.loadText()!
       
    }
    
    
}











