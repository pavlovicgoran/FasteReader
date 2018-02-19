//
//  File.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/19/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import Foundation
import UIKit

class ToolStyle{
    // Play button
    public func playButtonStyle(for button: UIButton){
        button.layer.cornerRadius = 4
        
        let highlightedAttributedString = NSAttributedString(string: "START READING", attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
        
        button.setAttributedTitle(highlightedAttributedString, for: .highlighted)
        
        let disabledAttributedString = NSAttributedString(string: "READING...", attributes:
            [NSAttributedStringKey.foregroundColor : UIColor.white])
        button.setAttributedTitle(disabledAttributedString, for: .disabled)
        button.setBackgroundColor(color: .red, forState: .disabled)
    }
    //Progress meter
    public func progressMeterStyle(for meter: UIProgressView){
        meter.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        meter.progress = 0.0
    }
    
    //Hiding and showing navbar
    public func hidingNavBar(navigationController: UINavigationController){
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    public func showingNavBar(navigationController: UINavigationController){
        navigationController.setNavigationBarHidden(false, animated: true)
    }
}
