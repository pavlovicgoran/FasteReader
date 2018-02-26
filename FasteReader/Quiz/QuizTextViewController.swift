//
//  QuizTextViewController.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/26/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import UIKit
//Properties and initialization
class QuizTextViewController: UIViewController {

    private let backgroundColor = UIColor(red: 0, green: 165/255, blue: 255/255, alpha: 1) // BLUE
    private let textColor =  UIColor.white
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stylizing()
        
    }
    

}
// MARK: Start the Quiz
extension QuizTextViewController{
    
}

// MARK: Stylizing
extension QuizTextViewController{
    private func stylizing(){
        setBackgroundColor()
        stylizingButton(button: continueButton)
        stylizingButton(button: cancelButton)
        stylizingTextView()
    }
    
    private func setBackgroundColor(){
        self.view.backgroundColor = backgroundColor
    }
    private func stylizingButton(button: UIButton){
        button.layer.borderWidth = 2
        button.layer.borderColor = textColor.cgColor
        button.layer.cornerRadius = 8
        
        button.setTitleColor(textColor, for: .normal)
        button.setTitleColor(backgroundColor, for: .highlighted)
        
    }
    private func stylizingTextView(){
        textView.isEditable = false
        textView.textColor = textColor
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 2
        textView.layer.borderColor = textColor.cgColor
        textView.indicatorStyle = .white
    }
}


