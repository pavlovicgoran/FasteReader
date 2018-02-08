//
//  TechniquesViewController.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/7/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import UIKit



enum ToolbarIdentifier: Int{
    case wordFlash = 0
    case diamond = 1
    case textHighlight = 2
    case extendVision = 3
}

// MARK: Properties and Initialization

class TechniquesViewController: UIViewController {

    let playPictureName = "play"
    let stopPictureName = "stop"
    
    @IBOutlet var toolbarButtons: [UIButton]!
    @IBOutlet weak var playButton: UIButton!
    
    var isPlaying = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Word Flash"
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        playButtonPressed()
    }
    
}
// MARK: Toolbar
extension TechniquesViewController{
    
    @IBAction func toolBarButtonPressed(_ sender: UIButton){
        
        
        setToolbarColor(color: .cyan)
        sender.backgroundColor = UIColor.white
        
        //sender.backgroundColor = UIColor.black
        
        switch sender.tag {
        case ToolbarIdentifier.wordFlash.rawValue:
            title = "Word Flash"
        case ToolbarIdentifier.diamond.rawValue:
            title = "Diamond Highlighter"
        case ToolbarIdentifier.textHighlight.rawValue:
            title = "Text Highlighter"
        case ToolbarIdentifier.extendVision.rawValue:
            title = "Extend Vision"
        default:
            print("Error another choice happened that was not registered")
        }
    }
    
    func setToolbarColor(color: UIColor){
        for button in toolbarButtons{
            button.backgroundColor = color
        }
    }
    
    
}
// MARK: Play button
extension TechniquesViewController{
    
    func playButtonPressed(){
        //print("Play pressed")
        isPlaying = !isPlaying
        
        if isPlaying{
            let image = UIImage(named: stopPictureName)
            playButton.setImage(image, for: .normal)
           // print("is playing")
        }else{
            let image = UIImage(named: playPictureName)
            playButton.setImage(image, for: .normal)
           // print("not playing")
        }
        
    }
    
}







