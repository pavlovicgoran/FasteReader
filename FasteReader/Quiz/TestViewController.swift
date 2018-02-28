//
//  TestViewController.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/25/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import UIKit
// MARK: Properties and Initialization
class TestViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stylizingStartButton()
        registerSwipes()
    }

    private func stylizingStartButton(){
        startButton.layer.borderWidth = 2
        startButton.layer.borderColor = UIColor.white.cgColor
        startButton.layer.cornerRadius = 8
        
    }
    
    @IBAction func unwindToQuizBegin(unwindSegue: UIStoryboardSegue){
        
    }
    
    // MARK: SWIPE REGISTER
    private func registerSwipes(){
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(swipe:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(swipe:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
    }
    
    
}
