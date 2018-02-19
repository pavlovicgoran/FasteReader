//
//  TechniquesViewController.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/7/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import UIKit



enum ToolbarIdentifier: Int{
    case wordFlash = 0
    case diamond = 1
    case textHighlight = 2
    case extendVision = 3
}

// MARK: Properties and Initialization

class TechniquesViewController: UIViewController {

    let playPictureName = "play"
    let stopPictureName = "stop"
    
    let worldFlashView = "worldFlash"
    let diamondHighlighterView = "diamondHighlighter"
    
    let toolNameWordFlash = "Word Flash"
    let toolNameDiamond = "Diamond Highlighter"
    let toolNameTextHighlighter = "Text Highlighter"
    let toolNameExpandVision = "Expand Vision"
    
    let toolbarColor = UIColor(red: 0.0, green: 165.0/255, blue: 1.0, alpha: 1.0)
    
    @IBOutlet var toolbarButtons: [UIButton]!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var currentReadingMaterial: UIButton!
    @IBOutlet weak var toolName: UILabel!
    @IBOutlet weak var toolDescription: UITextView!
    
    private var activeTool = ToolbarIdentifier.wordFlash
    

    override func viewDidLoad() {
        super.viewDidLoad()

        stylizingPlayButton()
        
        currentReadingMaterial.disclosureButton(baseColor: view.tintColor)
        
        populateToolDescriptions()
        
        
        updateReadingMaterial()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        BookChapter.saveCurrentChapter()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        BookChapter.restoreCurrentChapter()
        updateReadingMaterial()
        restore()
    }
    
    private func populateToolDescriptions(){
        DispatchQueue.main.async {[unowned self] in
            ToolsDescription.populateDescriptions()
            self.setToolDescription(for: .wordFlash)
        }
    }
    
    //Start the Session button
    @IBAction func playButtonPressed(_ sender: UIButton) {
        startTheTool(tool: activeTool)
    }
    
    //Reading Material button
    @IBAction func chooseReadingMaterial(_ sender: UIButton) {
        chooseReadingMaterial()
    }
    
}
// MARK: Toolbar
extension TechniquesViewController{
    
    @IBAction func toolBarButtonPressed(_ sender: UIButton){
        
        
        setToolbarColor(color: toolbarColor)
        sender.backgroundColor = UIColor.white
        
        
        switch sender.tag {
        case ToolbarIdentifier.wordFlash.rawValue:
            toolName.text = toolNameWordFlash
            activeTool = .wordFlash
            
            
        case ToolbarIdentifier.diamond.rawValue:
            toolName.text = toolNameDiamond
            activeTool = .diamond
            
        case ToolbarIdentifier.textHighlight.rawValue:
            toolName.text = toolNameTextHighlighter
            activeTool = .textHighlight
            
        case ToolbarIdentifier.extendVision.rawValue:
            toolName.text = toolNameExpandVision
            activeTool = .extendVision
            
        default:
            print("Error another choice happened that was not registered")
        }
        
        setToolDescription(for: activeTool)
    }
    
    func setToolbarColor(color: UIColor){
        for button in toolbarButtons{
            button.backgroundColor = color
        }
    }
    
    
}
// MARK: Play button
extension TechniquesViewController{
    
    private func startTheTool(tool: ToolbarIdentifier){
        
        
        switch activeTool {
        case .wordFlash:
            
            let worldFlash = storyboard?.instantiateViewController(withIdentifier: worldFlashView) as! WorldFlashViewController
            
            navigationController?.pushViewController(worldFlash, animated: true)
            
            break
        case .diamond:
            let diamondHighlighter = storyboard?.instantiateViewController(withIdentifier: diamondHighlighterView) as! DiamondHighlighterUIViewController
            
            navigationController?.pushViewController(diamondHighlighter, animated: true)
            break
        case .textHighlight:
            break
        case .extendVision:
            break
        default:
            print("start tool - another tool exists")
        }
    }
    
    private func stylizingPlayButton(){
        
        playButton.layer.cornerRadius = 4
        
        let highlightedAttributedString = NSAttributedString(string: "Start the Session", attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
        
        playButton.setAttributedTitle(highlightedAttributedString, for: .highlighted)
    }
    
}
// MARK: Reading material
extension TechniquesViewController: LibraryPicker{
    //Switch to library collection view controller
    func chooseReadingMaterial(){
        let tabBar = tabBarController as! BookTabController
        tabBar.tabBarController(tabBar, shouldSelect: tabBar.viewControllers![3])
        tabBar.selectedIndex = 3
        
    }
    
    func updateReadingMaterial(){
        currentReadingMaterial.setTitle(BookChapter.currentlyReading, for: .normal)
    }
}

// MARK: TextArea management
extension TechniquesViewController{
    
    func setToolDescription(for tool: ToolbarIdentifier){
        
        switch tool {
        case .wordFlash:
            toolDescription.text = ToolsDescription.wordFlashDescription
        case .diamond:
            toolDescription.text = ToolsDescription.diamondHighlighterDescription
        case .textHighlight:
            toolDescription.text = ToolsDescription.textHighlighterDescription
        case .extendVision:
            toolDescription.text = ToolsDescription.expandVisionDescription
        default:
            print("TextArea management - another tool exists")
        }
        
        
    }
    
    
}

//MARK: Restoring Profile values
extension TechniquesViewController{
    
    private func restore(){
        let defaults = UserDefaults.standard
        
        let wpmText = defaults.string(forKey: ProfileViewController.keyWPM) ?? "500"
        let wpm = Int(wpmText)
        
        let lineLengthText = defaults.string(forKey: ProfileViewController.keyLineLength) ?? "Line Length: 1"
        let lineLength = Int(lineLengthText.digitsOnly())
        
        let numberOfLinesText = defaults.string(forKey: ProfileViewController.keyNumberOfLines) ?? "Number of Lines: 1"
        let numberOfLines = Int(numberOfLinesText.digitsOnly())
        
        restoreProfileInstance(wpm: wpm!, lineLenght: lineLength!, numberOfLines: numberOfLines!)
        
    }
    
    private func restoreProfileInstance(wpm: Int, lineLenght: Int, numberOfLines: Int){
        Profile.sharedInstance.setWordsPerMinute(wpm: wpm)
        Profile.sharedInstance.setLineLength(lineLength: lineLenght)
        Profile.sharedInstance.setNumberOfLines(numberOfLines: numberOfLines)
    }
    
}











