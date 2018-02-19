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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stylizingPlayButton()
        stylizingProgressMeter()
    }

    
}

// MARK: UI Stylizing
extension DiamondHighlighterUIViewController{
    
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
