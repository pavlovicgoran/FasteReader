//
//  ProfileViewController.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/12/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import UIKit

// MARK: Properties and Initialization
class ProfileViewController: UIViewController {

    @IBOutlet weak var currentlyReading: UIButton!
    
    @IBOutlet weak var lineLength: UILabel!
    @IBOutlet weak var numberOfLines: UILabel!
    @IBOutlet weak var wordsPerMinute: UILabel!
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        currentlyReading.disclosureButton(baseColor: view.tintColor)
        updateReadingMaterial()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(changeUsername))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(pickPhoto))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateReadingMaterial()
    }
    
    //Reading material button
    @IBAction func chooseReadingMaterial(_ sender: UIButton) {
        chooseReadingMaterial()
    }
    
    //Line length stepper
    @IBAction func lineLengthChanged(_ sender: UIStepper) {
        lineLength.text = "Line Length: \(Int(sender.value))"
    }
    
    //Number of lines stepper
    @IBAction func numberOfLinesChanged(_ sender: UIStepper) {
        numberOfLines.text = "Number of Lines: \(Int(sender.value))"
    }
    
    //Words per minute slider
    @IBAction func wordsPerMinuteChanged(_ sender: UISlider) {
        wordsPerMinute.text = "\(Int(sender.value))"
    }
    
    
}

// MARK: Currently reading button
extension ProfileViewController: LibraryPicker{
    func chooseReadingMaterial(){
        let tabBar = tabBarController as! BookTabController
        tabBar.tabBarController(tabBar, shouldSelect: tabBar.viewControllers![3])
        tabBar.selectedIndex = 3
        
    }
    
    func updateReadingMaterial(){
        currentlyReading.setTitle(BookChapter.currentlyReading, for: .normal)
    }
}

// MARK: Navbar buttons
extension ProfileViewController{
    
    @objc func changeUsername(){
        print("changeUsername")
        let ac = UIAlertController(title: "Enter your username", message: nil, preferredStyle: .alert)
        ac.addTextField(configurationHandler:{ (_ textField: UITextField) -> Void in
            textField.placeholder = "Enter username"
            
        })
        ac.addAction(UIAlertAction(title: "Save", style: .default, handler: { [unowned self](_ action: UIAlertAction) in
            
            if (!(ac.textFields![0].text?.isEmpty)!){
                self.username.text = ac.textFields![0].text
            }
        }))
        
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    @objc func pickPhoto(){
        print("pickPhoto")
    }
    
}






