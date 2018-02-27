//
//  QuizTextViewController.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/26/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import UIKit
import GameplayKit

//Properties and initialization
class QuizTextViewController: UIViewController {

    private let backgroundColor = UIColor(red: 0, green: 165/255, blue: 255/255, alpha: 1) // BLUE
    private let textColor =  UIColor.white
    
    private let startQuizSegueID = "startQuiz"
    
    private let mountRushmoreFile = "mount_rushmore"
    private let teotihuacanFile = "teotihuacan"
    
    private var quizTexts = [String]()
    
    private var beginningTime: Date!
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        stylizing()
        initialazeQuizTexts()
        
        beginningTime = Date()
    }
    
    private func initialazeQuizTexts(){
        quizTexts.append(mountRushmoreFile)
        quizTexts.append(teotihuacanFile)
        
        quizTexts = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: quizTexts) as! [String]
        
        initialazeTextView()
    }
    
    private func initialazeTextView(){
        if let path = Bundle.main.path(forResource: quizTexts[0], ofType: "txt"){
            if let text = try? String(contentsOfFile: path){
                textView.text = text
            }
        }
    }
    
    
    
}
// MARK: Start the Quiz
extension QuizTextViewController{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? QuestionViewController{
            let endTime = Date()
            let interval = endTime.timeIntervalSince(beginningTime)
            vc.readingTime = Int(interval)
            vc.questionFile = "\(quizTexts[0])_questions";
            vc.numberOfWords = textView.text.count
        }
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


