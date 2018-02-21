//
//  TextHighlighterViewController.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/21/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import UIKit
// MARK: Properties and Initialization
class TextHighlighterViewController: UIViewController {

    private let unwindSegueID = "unwindFromText"
    private let numberOfTextRows = 12
    private let numberOfWordsInRow = 3
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var progressMeter: UIProgressView!
    @IBOutlet weak var textContainer: UIStackView!
    
    private let toolStyle = ToolStyle()
    
    private var timerProgress = Timer()
    private var timerReading = Timer()
    
    private var passedTime = 0.0
    private let totalTime = 60.0
    
    private var delay = 0.0
    
    private var wordsPerMinute: Int!
    
    
    private var book: BookPrefixes!
    private var chapterNumber: Int!
    
    private var textToRead = [String]()
    private var labelArray = [UILabel]()
    
    private var wordIndex = 0
    private var highlightedWord = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toolStyle.playButtonStyle(for: playButton)
        toolStyle.progressMeterStyle(for: progressMeter)
        initialaze()
    }
    
    private func initialaze(){
        wordsPerMinute = Profile.sharedInstance.getWordsPerMinute()
        delay = (TimeConstants.SEC_TO_MILSEC / (Double(wordsPerMinute) / (TimeConstants.MIN_TO_SEC))) * 0.001 * Double(numberOfWordsInRow)
        
        book = BookChapter.getBook()
        chapterNumber = BookChapter.getChapterNumber()
        
        initialazeText()
        initialazeTextContainer()
        setUpLabelText()
    }
    
    private func initialazeTextContainer(){
        
        textContainer.distribution = .fillEqually
        textContainer.spacing = 5
        
        for i in 0 ..< numberOfTextRows{
            let horizontalContainer = UIStackView()
            horizontalContainer.axis = .horizontal
            horizontalContainer.distribution = .fillEqually
            horizontalContainer.spacing = 0
            
            for j in 0 ..< numberOfWordsInRow{
                let label = UILabel()
                label.text = "\(i)-\(j)"
                label.textAlignment = .center
                labelArray.append(label)
                horizontalContainer.addArrangedSubview(label)
            }
            
            textContainer.addArrangedSubview(horizontalContainer)
        }
    }
    
    private func setUpLabelText(){
        guard textToRead.count > numberOfWordsInRow * numberOfTextRows else {
            print("premali tekst")
            return
        }
        
        for i in 0 ..< labelArray.count{
            labelArray[i].text = textToRead[i]
        }
        labelArray[0].textColor = UIColor.red
        wordIndex = numberOfWordsInRow * numberOfTextRows
    }
    
    private func clearLabels(){
        for label in labelArray{
            label.text = ""
        }
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        playButton.isEnabled = false
        toolStyle.hidingNavBar(navigationController: navigationController!)
        timerProgress = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        
        read()
    }
    
}
// MARK: Progress view update
extension TextHighlighterViewController{
    
    @objc func updateProgress(){
        passedTime += 1
        if passedTime >= totalTime{
            reset()
            return
        }
        let progress = Float(passedTime)/Float(totalTime)
        progressMeter.setProgress(progress, animated: true)
    }
    
    private func reset(){
        timerProgress.invalidate()
        timerReading.invalidate()
        
        setOverScreen()
        
        returnToTechniquesView()
    }
    
    private func setOverScreen(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){[unowned self] in
            self.clearLabels()
            let index = (self.labelArray.count + self.numberOfWordsInRow) / 2
            self.labelArray[index].textColor = UIColor.red
            self.labelArray[index].text = "Congrats"
        }
   
    }
    
    private func returnToTechniquesView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){[unowned self] in
            self.toolStyle.showingNavBar(navigationController: self.navigationController!)
            self.performSegue(withIdentifier: self.unwindSegueID, sender: nil)
        }
    }
    
}

// MARK: Reading tool protocol
extension TextHighlighterViewController: ReadingTool{
    func read() {
        timerReading = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(showingText), userInfo: nil, repeats: true)
        //print(delay)
    }
    
    func initialazeText() {
        let textLoader = TextLoader(book: book, chapterNumber: chapterNumber)
        textToRead = textLoader.loadText()!
        //print(textToRead)
    }
    
    @objc func showingText(){
        
        
        guard (wordIndex + numberOfWordsInRow) < (textToRead.count - 1) else {
            reset()
            return
        }
        highlightedWord += 1
        if highlightedWord == numberOfWordsInRow{
            highlightedWord = 0
            textScroll()
        }
        
        setHighlightedWord()
    }
    
    private func setHighlightedWord(){
        for i in 0 ..< numberOfWordsInRow{
            labelArray[i].textColor = UIColor.black
        }
        labelArray[highlightedWord].textColor = UIColor.red
        labelArray[highlightedWord].font = labelArray[highlightedWord].font.withSize(18.0)
    }
    
    private func textScroll(){
        for i in (numberOfWordsInRow )...(labelArray.count - 1){
            labelArray[i - numberOfWordsInRow].text = labelArray[i].text
        }
        for j in 0 ..< numberOfWordsInRow{
            let index = labelArray.count - numberOfWordsInRow + j
            labelArray[index].text = textToRead[wordIndex]
            
            wordIndex += 1
        }
    }
    
}






