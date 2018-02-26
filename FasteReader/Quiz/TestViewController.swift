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
    }

    private func stylizingStartButton(){
        startButton.layer.borderWidth = 2
        startButton.layer.borderColor = UIColor.white.cgColor
        startButton.layer.cornerRadius = 8
        
    }
    
    @IBAction func unwindToQuizBegin(unwindSegue: UIStoryboardSegue){
        
    }
    
}
