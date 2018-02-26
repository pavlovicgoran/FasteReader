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

    private let backgroundColor = UIColor(red: 99/255, green: 4/255, blue: 0, alpha: 1) // DARK RED
    private let textColor =  UIColor(red: 255/255, green: 221/255, blue: 129/255, alpha: 1) // GOLD
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stylizing()
        
    }
    
   

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


