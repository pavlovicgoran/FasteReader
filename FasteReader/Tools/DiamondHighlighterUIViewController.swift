//
//  DiamondHighlighterUIViewController.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/18/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import UIKit

enum ShowingOrder{
    case increasing
    case decreasing
}

// MARK: Properties and Initialization
class DiamondHighlighterUIViewController: UIViewController {

    private let numberOfLabels = 12
    
    private var numberOfTheGuidingLabel: Int{
        return (numberOfLabels / 2) - 1
    }
    
    @IBOutlet weak var progressMeter: UIProgressView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var labelContainer: UIStackView!
    
    private var labelArray = [UILabel]()
    
    private var wordsPerMinute: Int!
    private var lineLength: Int!
    
    private var book: BookPrefixes!
    private var chapterNumber: Int!
    
    private var textToRead = [String]()
    
    private var timerProgress = Timer()
    private var timerReading = Timer()
    private let totalTime = 60.0
    private var passedTime = 0.0
    
    private var delay = 0.0
    
    private var wordIndex = 0
    private var numberOfWordsToShow = 1
    private var showingOrder: ShowingOrder = .increasing
    
    private let toolStyle = ToolStyle()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Diamond Highlighter"
        
        toolStyle.playButtonStyle(for: playButton)
        toolStyle.progressMeterStyle(for: progressMeter)
        initialazeLabelContainer()
        initialaze()
    }
    
    private func initialazeLabelContainer(){
        
        for i in 0 ..< numberOfLabels{
            let label = UILabel()
            label.text = "When you are ready"
            label.textAlignment = .center
            
            if i == numberOfTheGuidingLabel{
                label.textColor = UIColor.red
                label.font = label.font.withSize(22.0)
            }
            
            labelArray.append(label)
            labelContainer.addArrangedSubview(label)
        }
        
        labelContainer.spacing = 0.0
        labelContainer.distribution = .fillEqually
    }
    
    private func initialaze(){
        wordsPerMinute = Profile.sharedInstance.getWordsPerMinute()
        lineLength = Profile.sharedInstance.getLineLength()
        book = BookChapter.getBook()
        chapterNumber = BookChapter.getChapterNumber()
        
         delay = (TimeConstants.SEC_TO_MILSEC / (Double(wordsPerMinute) / (TimeConstants.MIN_TO_SEC))) * 0.001 * (Double(lineLength) + 1.0) / 2
        
        initialazeText()
    }

    @IBAction func playButtonTapped(_ sender: UIButton) {
        clearLabels()
        playButton.isEnabled = false
        toolStyle.hidingNavBar(navigationController: navigationController!)
        timerProgress = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(progressUpdate), userInfo: nil, repeats: true)
        
        
        read()
    }
    
    private func clearLabels(){
        for label in labelArray{
            label.text = ""
        }
    }
    
}
// MARK: Progress meter and reset function
extension DiamondHighlighterUIViewController{
    
    @objc func progressUpdate(){
        
        passedTime += 1
        if passedTime >= totalTime{
            reset()
            return
        }
        
        let progress = passedTime / totalTime
        progressMeter.setProgress(Float(progress), animated: true)
        
    }
    
    private func reset(){
        timerProgress.invalidate()
        timerReading.invalidate()
        
        setOverText()
        
       returnToTechniquesView()
        
    }
    
    private func returnToTechniquesView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.toolStyle.showingNavBar(navigationController: self.navigationController!)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setOverText(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){[unowned self] in
            self.clearLabels()
            self.labelArray[self.numberOfTheGuidingLabel].text = "Congratulations "
        }
    }
}
// MARK: ReadingTool protocol
extension DiamondHighlighterUIViewController: ReadingTool{
    func read() {
        //print(delay)
        timerReading = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(showingText), userInfo: nil, repeats: true)
    }
    
    @objc func showingText(){
        calculateWordsToShow()
        
        
        if wordIndex + numberOfWordsToShow >= textToRead.count{
            
            reset()
            return
        }
        
        var wordToShow = ""
        for i in 0 ..< numberOfWordsToShow{
            wordToShow += "\(textToRead[wordIndex + i]) "
        }
        wordIndex += numberOfWordsToShow
        
        updateLabels(text: wordToShow)
        
    }
    
    private func updateLabels(text: String){
        
        for i in 0 ..< (numberOfLabels - 1){
            labelArray[i].text = labelArray[i + 1].text
        }
        labelArray[numberOfLabels - 1].text = text
    }
    
    private func calculateWordsToShow(){
        switch showingOrder {
        case .increasing:
            if numberOfWordsToShow == lineLength{
                numberOfWordsToShow -= 1
                showingOrder = .decreasing
            }else{
                numberOfWordsToShow += 1
            }
            
        case .decreasing:
            if numberOfWordsToShow == 1{
                numberOfWordsToShow += 1
                showingOrder = .increasing
            }else{
                numberOfWordsToShow -= 1
            }
        default:
            print("There si another showing Order in Diamond Highlighter")
        }
        
    }
    
    func initialazeText() {
        let textLoader = TextLoader(book: book, chapterNumber: chapterNumber)
        textToRead = textLoader.loadText()!
        
    }
    
    
}












