//
//  QuestionViewController.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/26/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import UIKit
import GameplayKit
// MARK: Properties and Initialization
class QuestionViewController: UIViewController {

    private let backgroundColor = UIColor(red: 0, green: 165/255, blue: 255/255, alpha: 1)
    private let textColor = UIColor.white
    
    private let unwindSegueID = "unwindFromQuestion"
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet var questionOptions: [QuizButton]!
    
    private var questions = [Question]()
    
    private var currentlyShowingAnswer = 0
    
    private var readingSpeed = 0
    
    var readingTime = 0
    var questionFile = ""
    var numberOfWords = 0
    var numberOfCorrectAnswers = 0
    
    private var progressView: KDCircularProgress!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stylaze()
        

        loadQuestions()
        questions = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: questions) as! [Question]
        updateQuestion()
        updateProgressView()
    }
    
    private func updateQuestion(){
        let questionContent = questions[currentlyShowingAnswer]
        
        
        
        question.text = questionContent.questionText
        var answers = questionContent.answers
        answers = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: answers) as! [Answer]
        for i in 0 ..< questionOptions.count{
            questionOptions[i].setTitle(answers[i].answerText, for: .normal)
            questionOptions[i].isCorrectAnswer = answers[i].isCorrect
        }
        
        
    }
    
    private func updateProgressView(){
        progressView.angle = 360.0 * Double(currentlyShowingAnswer)/Double(questions.count)
    }
    
    @IBAction func answerButton(_ sender: QuizButton) {
        
        if sender.isCorrectAnswer {
            numberOfCorrectAnswers += 1
        }
        
        guard currentlyShowingAnswer + 1 < questions.count else{
            currentlyShowingAnswer += 1
            updateProgressView()
            calculateReadingSpeed()
            savingWPM()
            
            let ac = UIAlertController(title: "Reading speed", message: "Your reading speed is \(readingSpeed) words per minute", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: {[unowned self](action) in
                self.performSegue(withIdentifier: self.unwindSegueID, sender: nil)
            }))
            present(ac, animated: true)
            
            return
        }
        currentlyShowingAnswer += 1
        updateQuestion()
        updateProgressView()
    }
    
    private func calculateReadingSpeed(){
        readingSpeed = (numberOfWords / readingTime) * Int((TimeConstants.MIN_TO_SEC) * ((Double(numberOfCorrectAnswers) * 0.16)))
        if readingSpeed > Profile.sharedInstance.maximumWPM{
            readingSpeed = Profile.sharedInstance.maximumWPM
        }
        if readingSpeed < Profile.sharedInstance.minimumWPM{
            readingSpeed = Profile.sharedInstance.minimumWPM
        }
    }
    
    private func savingWPM(){
        let defaults = UserDefaults.standard
        defaults.set(readingSpeed, forKey: ProfileViewController.keyWPM)
        Profile.sharedInstance.setWordsPerMinute(wpm: readingSpeed)
    }

}

// MARK: Parsing question file
extension QuestionViewController{
    private func loadQuestions(){
        //load question file in string
        guard let fileContents = loadFileContents() else{
            print("ERROR LOADING QUESTION FILE")
            return
        }
        
        //split file at ####
        
        let questions = fileContents.components(separatedBy: "####")
        
        //create Question
        for question in questions{
            createQuestion(stringToParse: question)
        }
        
    }
    
    private func createQuestion(stringToParse: String){
        // split string -
        var stringComponents = stringToParse.components(separatedBy: "-")
        
        //assign first as text
        let question = Question(question: stringComponents[0])
        
        for i in 1 ... stringComponents.count - 1{
            // create answer
            let answer = Answer(stringToParse: stringComponents[i])
            
            //add answer to question
            question.addAnswer(answer: answer)
        }
        
        //add question
        questions.append(question)
    }
    
    
    private func loadFileContents() -> String?{
        if let path = Bundle.main.path(forResource: questionFile, ofType: "txt"){
            if let text = try? String(contentsOfFile: path){
                return text
            }
        }
        return nil
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
        
        setupProgressView()
    }
    
    private func setupProgressView(){
        progressView = KDCircularProgress(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        progressView.startAngle = 90
        progressView.angle = 0
        progressView.trackColor = .white
        progressView.progressColors = [.lightGray, backgroundColor]
        progressView.center = view.center
        progressView.center.y = view.frame.maxY - 60
        progressView.layer.zPosition = 3
        view.addSubview(progressView)
    }
    
}





