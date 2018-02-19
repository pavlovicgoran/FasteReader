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
    
    private let toolStyle = ToolStyle()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Diamond Highlighter"
        
        toolStyle.playButtonStyle(for: playButton)
        toolStyle.progressMeterStyle(for: progressMeter)
        
    }

    
}


