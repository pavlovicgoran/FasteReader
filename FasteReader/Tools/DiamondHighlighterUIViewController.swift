//
//  DiamondHighlighterUIViewController.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/18/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import UIKit
// MARK: Properties and Initialization
class DiamondHighlighterUIViewController: UIViewController {

    @IBOutlet weak var progressMeter: UIProgressView!
    @IBOutlet weak var playButton: UIButton!
   
    
    private var timerProgress = Timer()
    private let totalTime = 60.0
    private var passedTime = 0.0
    
    private let toolStyle = ToolStyle()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Diamond Highlighter"
        
        toolStyle.playButtonStyle(for: playButton)
        toolStyle.progressMeterStyle(for: progressMeter)
        
       
        
    }

    @IBAction func playButtonTapped(_ sender: UIButton) {
        
        playButton.isEnabled = false
        toolStyle.hidingNavBar(navigationController: navigationController!)
        timerProgress = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(progressUpdate), userInfo: nil, repeats: true)
    }
    
    
    
}

extension DiamondHighlighterUIViewController{
    
    @objc func progressUpdate(){
        
        passedTime += 1
        if passedTime >= totalTime{
            reset()
        }
        
        let progress = passedTime / totalTime
        progressMeter.setProgress(Float(progress), animated: true)
        
    }
    
    private func reset(){
        timerProgress.invalidate()
        toolStyle.showingNavBar(navigationController: navigationController!)
        navigationController?.popViewController(animated: true)
        
    }
}

extension DiamondHighlighterUIViewController: ReadingTool{
    func read() {
        
    }
    
    func initialazeText() {
        
    }
    
    
}












