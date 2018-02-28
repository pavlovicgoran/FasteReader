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

    public static let keyUsername = "USERNAME"
    public static let keyWPM = "WORDS_PER_MINUTE"
    public static let keyNumberOfLines = "NUMBER_OF_LINES"
    public static let keyLineLength = "LINE_LENGTH"
    public static let keyImage = "IMAGE"
    
    private let defaultProfileImage = "profile_empty"
    
    @IBOutlet weak var currentlyReading: UIButton!
    
    @IBOutlet weak var lineLength: UILabel!
    @IBOutlet weak var numberOfLines: UILabel!
    @IBOutlet weak var wordsPerMinute: UILabel!
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var wpmSlider: UISlider!
    @IBOutlet weak var numberOfLinesStepper: UIStepper!
    @IBOutlet weak var lineLengthStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        currentlyReading.disclosureButton(baseColor: view.tintColor)
        updateReadingMaterial()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(changeUsername))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(pickPhoto))
        
        stylizingProfilePic()
        
        registerLeftSwipe()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateReadingMaterial()
        restoreState()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        saveToUserDefaults()
    }
    
    //Rounding image view
    private func stylizingProfilePic(){
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.clipsToBounds = true
    }
    
    //Reading material button
    @IBAction func chooseReadingMaterial(_ sender: UIButton) {
        chooseReadingMaterial()
    }
    
    //Line length stepper
    @IBAction func lineLengthChanged(_ sender: UIStepper) {
        lineLength.text = "Line Length: \(Int(sender.value))"
        Profile.sharedInstance.setLineLength(lineLength: Int(sender.value))
        saveToUserDefaults()
    }
    
    //Number of lines stepper
    @IBAction func numberOfLinesChanged(_ sender: UIStepper) {
        numberOfLines.text = "Number of Lines: \(Int(sender.value))"
        Profile.sharedInstance.setNumberOfLines(numberOfLines: Int(sender.value))
        saveToUserDefaults()
    }
    
    //Words per minute slider
    @IBAction func wordsPerMinuteChanged(_ sender: UISlider) {
        wordsPerMinute.text = "\(Int(sender.value))"
        Profile.sharedInstance.setWordsPerMinute(wpm: Int(sender.value))
        saveToUserDefaults()
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
                self.saveToUserDefaults()
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
        saveToUserDefaults()
        Profile.sharedInstance.setProfileImage(image: image)
        
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

// MARK: Saving to User defaults

extension ProfileViewController{
    
    private func saveToUserDefaults(){
        
        let defaults = UserDefaults.standard
        defaults.set(lineLength.text, forKey: ProfileViewController.keyLineLength)
        defaults.set(numberOfLines.text, forKey: ProfileViewController.keyNumberOfLines)
        defaults.set(username.text, forKey: ProfileViewController.keyUsername)
        defaults.set(wordsPerMinute.text, forKey: ProfileViewController.keyWPM)
        
        if let profilePic = profileImage.image{
            defaults.set(UIImageJPEGRepresentation(profilePic, 0.8), forKey: ProfileViewController.keyImage)
        }
        
        BookChapter.saveCurrentChapter()
        
    }
    
    private func restoreState(){
        let defaults = UserDefaults.standard
        lineLength.text = defaults.string(forKey: ProfileViewController.keyLineLength) ?? "Line Length: 1"
        numberOfLines.text = defaults.string(forKey: ProfileViewController.keyNumberOfLines) ?? "Number of Lines: 1"
        username.text = defaults.string(forKey: ProfileViewController.keyUsername)
        wordsPerMinute.text = defaults.string(forKey: ProfileViewController.keyWPM) ?? "500"
        
         //profileImage.image = defaults.object(forKey: keyImage) as? UIImage
        if let imgData = defaults.object(forKey: ProfileViewController.keyImage) as? Data{
            let img = UIImage(data: imgData)
            profileImage.image = img
        }else{
            profileImage.image = UIImage(named: defaultProfileImage)
        }
        
        
        
        restoreSliderAndSteppers()
        
        BookChapter.restoreCurrentChapter()
        updateReadingMaterial()
    }
    
    private func restoreSliderAndSteppers(){
        wpmSlider.value = Float(wordsPerMinute.text!)!
        let lineLengthValue = Int((lineLength.text?.digitsOnly())!)
        lineLengthStepper.value = Double(lineLengthValue!)
        let numberOfLinesValue = Int((numberOfLines.text?.digitsOnly())!)
        numberOfLinesStepper.value = Double(numberOfLinesValue!)

        restoreProfileInstance(wpm: Int(wpmSlider.value), lineLenght: lineLengthValue!, numberOfLines: numberOfLinesValue!)
    }
    
    private func restoreProfileInstance(wpm: Int, lineLenght: Int, numberOfLines: Int){
        Profile.sharedInstance.setWordsPerMinute(wpm: wpm)
        Profile.sharedInstance.setLineLength(lineLength: lineLenght)
        Profile.sharedInstance.setNumberOfLines(numberOfLines: numberOfLines)
    }
    
}
// MARK: LEFT SWIPE
extension ProfileViewController{
    private func registerLeftSwipe(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(swipe:)))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
    }
}











