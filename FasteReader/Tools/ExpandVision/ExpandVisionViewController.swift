//
//  ExpandVisionViewController.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/23/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import UIKit

class ExpandVisionViewController: UIViewController {

    @IBOutlet weak var showingLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var progressMeter: UIProgressView!
    
    private let toolStyle = ToolStyle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toolStyle.playButtonStyle(for: playButton)
        toolStyle.progressMeterStyle(for: progressMeter)
    }

}
