//
//  QuestionViewController.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/26/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    private let backgroundColor = UIColor(red: 0, green: 165/255, blue: 255/255, alpha: 1)
    private let textColor = UIColor.white
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet var questionOptions: [QuizButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stylaze()
    }

    

}

// MARK: Stylizing
extension QuestionViewController{
    private func setupBackgroundColor(){
        view.backgroundColor = backgroundColor
    }
    
    private func setupLabel(){
        question.textColor = .white
    }
    
    private func stylizingButton(button: UIButton){
        button.layer.borderWidth = 2
        button.layer.borderColor = textColor.cgColor
        button.layer.cornerRadius = 8
        
        button.setTitleColor(textColor, for: .normal)
        button.setTitleColor(backgroundColor, for: .highlighted)
    }
    
    private func stylaze(){
        setupLabel()
        setupBackgroundColor()
        for button in questionOptions{
            stylizingButton(button: button)
        }
    }
}
