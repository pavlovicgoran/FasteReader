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

    
    @IBOutlet var toolbarButtons: [UIButton]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Word Flash"
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







