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
        Profile.sharedInstance.setLineLength(lineLength: Int(sender.value))
    }
    
    //Number of lines stepper
    @IBAction func numberOfLinesChanged(_ sender: UIStepper) {
        numberOfLines.text = "Number of Lines: \(Int(sender.value))"
        Profile.sharedInstance.setNumberOfLines(numberOfLines: Int(sender.value))
    }
    
    //Words per minute slider
    @IBAction func wordsPerMinuteChanged(_ sender: UISlider) {
        wordsPerMinute.text = "\(Int(sender.value))"
        Profile.sharedInstance.setWordsPerMinute(wpm: Int(sender.value))
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
    
    //Right bar button
    @objc func changeUsername(){
        
        let ac = UIAlertController(title: "Enter your username", message: nil, preferredStyle: .alert)
        ac.addTextField(configurationHandler:{ (_ textField: UITextField) -> Void in
            textField.placeholder = "Enter username"
            
        })
        ac.addAction(UIAlertAction(title: "Save", style: .default, handler: { [unowned self](_ action: UIAlertAction) in
            
            if (!(ac.textFields![0].text?.isEmpty)!){
                self.username.text = ac.textFields![0].text
                Profile.sharedInstance.setUsername(username: self.username.text!)
            }
        }))
        
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    //Left bar button
    @objc func pickPhoto(){
        let ac = UIAlertController(title: "Upload the profile image", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Take a photo", style: .default, handler: {[unowned self](_ action: UIAlertAction) in
            
            self.imagePicker(source: .camera)
        }))
        
        ac.addAction(UIAlertAction(title: "Pick a photo", style: .default, handler: {[unowned self](_ action: UIAlertAction) in
            self.imagePicker(source: .photoLibrary)
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    
    
}
// MARK: Picking images from a library

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    private func imagePicker(source: UIImagePickerControllerSourceType){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        
        picker.sourceType = source
        
        present(picker, animated: true)
    }
    // MARK: Image picker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        
        
        profileImage.image = image
        
        Profile.sharedInstance.setProfileImage(image: image)
        
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}











