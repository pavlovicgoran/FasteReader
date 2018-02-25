//
//  ExpandVisionViewController.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/23/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import UIKit
// MARK: Properties and Initialization
class ExpandVisionViewController: UIViewController {

    private let unwindSegue = "unwindFromExpand"
    
    @IBOutlet weak var showingLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var progressMeter: UIProgressView!
    
    private let toolStyle = ToolStyle()
    
    private var timerProgress = Timer()
    private var timerReading = Timer()
    
    private let totalTime = 60.0
    private var passedTime = 0.0
    
    private var wordsPerMinute: Int!
    private var lineLength: Int!
    private var numberOfLines: Int!
    
    private var numberOfWordShowing: Int{
        return lineLength * numberOfLines
    }
    
    private var delay = 0.0
    
    private var book: BookPrefixes!
    private var chapterNumber: Int!
    
    private var textToRead = [String]()
    private var wordIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toolStyle.playButtonStyle(for: playButton)
        toolStyle.progressMeterStyle(for: progressMeter)
        
        initialaze()
    }
    
    
    private func initialaze(){
        wordsPerMinute = Profile.sharedInstance.getWordsPerMinute()
        lineLength = Profile.sharedInstance.getLineLength()
        numberOfLines = Profile.sharedInstance.getNumberOfLines()
        
        book = BookChapter.getBook()
        chapterNumber = BookChapter.getChapterNumber()
        
        delay = (TimeConstants.SEC_TO_MILSEC / (Double(wordsPerMinute) / (TimeConstants.MIN_TO_SEC))) * 0.001 * Double(numberOfWordShowing)
        
        initialazeText()
    }

    @IBAction func playButtonTapped(_ sender: UIButton) {
        playButton.isEnabled = false
        toolStyle.hidingNavBar(navigationController: navigationController!)
        
        timerProgress = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(progressUpdate), userInfo: nil, repeats: true)
        
        read()
    }
    
}

// MAR: Progress view update
extension ExpandVisionViewController{
    
    @objc func progressUpdate(){
        passedTime += 1
        
        if passedTime >= totalTime{
            reset()
            return
        }
        
        progressMeter.setProgress(Float(passedTime/totalTime), animated: true)
    }
    
    private func reset(){
        timerProgress.invalidate()
        timerReading.invalidate()
        setOverText()
        returnToTechniquesView()
    }
    
    private func setOverText(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){[unowned self] in
            self.showingLabel.textColor = UIColor.red
            self.showingLabel.text = "Session finished successfully\n Congratulations"
        }
    }
    
    private func returnToTechniquesView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){[unowned self] in
            self.toolStyle.showingNavBar(navigationController: self.navigationController!)
            self.performSegue(withIdentifier: self.unwindSegue, sender: nil)
        }
    }
}


// MARK: Reading tool protocol
extension ExpandVisionViewController: ReadingTool{
    func read() {
        timerReading = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(showingText), userInfo: nil, repeats: true)
        
    }
    
    @objc func showingText(){
        guard (wordIndex + numberOfWordShowing) < (textToRead.count - 1)  else {
            reset()
            return
        }
        
        var wordsToShow = ""
        
        for i in 0 ..< numberOfWordShowing{
            wordsToShow += textToRead[wordIndex + i] + " "
            if (i + 1) % lineLength == 0{
                wordsToShow += "\n"
            }
        }
        
        wordIndex += numberOfWordShowing
        showingLabel.text = wordsToShow
        
    }
    
    func initialazeText() {
        let textLoader = TextLoader(book: book, chapterNumber: chapterNumber)
        textToRead = textLoader.loadText()!
        
    }
    
    
}






