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
    @IBOutlet weak var currentReadingMaterial: UIButton!
    
    private var activeTool = ToolbarIdentifier.wordFlash

    override func viewDidLoad() {
        super.viewDidLoad()

        stylizingPlayButton()
        
        currentReadingMaterial.disclosureButton(baseColor: view.tintColor)
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        startTheTool(tool: activeTool)
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
            
            activeTool = .wordFlash
            
        case ToolbarIdentifier.diamond.rawValue:
            
            activeTool = .diamond
            
        case ToolbarIdentifier.textHighlight.rawValue:
            
            activeTool = .textHighlight
            
        case ToolbarIdentifier.extendVision.rawValue:
            
            activeTool = .extendVision
            
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
    
    private func startTheTool(tool: ToolbarIdentifier){
        print("Active tool: \(activeTool)")
    }
    
    private func stylizingPlayButton(){
        
        playButton.layer.cornerRadius = playButton.frame.height / 2
        
        let highlightedAttributedString = NSAttributedString(string: "Start the Session", attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
        
        playButton.setAttributedTitle(highlightedAttributedString, for: .highlighted)
    }
    
}







