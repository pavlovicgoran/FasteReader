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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        currentlyReading.disclosureButton(baseColor: view.tintColor)
        updateReadingMaterial()
    }
    
    @IBAction func chooseReadingMaterial(_ sender: UIButton) {
        chooseReadingMaterial()
    }
    
}

//MARK: Currently reading button
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
