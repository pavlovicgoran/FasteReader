//
//  ButtonBackgroundForState.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/17/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        self.setBackgroundImage(colorImage, for: forState)
        self.clipsToBounds = true
    }
 
    
}
// MARK: Button Style Used In Quiz Feature
class QuizButton: UIButton {
    
    fileprivate var titleColorNormal: UIColor = .white
    fileprivate var titleColorHighlighted: UIColor = UIColor(red: 0, green: 165/255, blue: 255/255, alpha: 1)
    fileprivate var backgroundColorNormal: UIColor = UIColor(red: 0, green: 165/255, blue: 255/255, alpha: 1)
    fileprivate var backgroundColorHighlighted: UIColor = .white
    override var isHighlighted: Bool {
        willSet(newValue){
            if newValue {
                self.setTitleColor(titleColorHighlighted, for: .highlighted)
                self.backgroundColor = backgroundColorHighlighted
            }else {
                self.setTitleColor(titleColorNormal, for: .normal)
                self.backgroundColor = backgroundColorNormal
            }
        }
    }
    
    public var isCorrectAnswer = false
    
 
}

