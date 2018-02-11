//
//  BookTabController.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/11/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import UIKit

class BookTabController: UITabBarController, UITabBarControllerDelegate {

    private let durationOfTransition: Double = 0.7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        return beginTransition(tabBarController, shouldSelect: viewController)
        
    }

    public func beginTransition(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool{
        let fromView: UIView = tabBarController.selectedViewController!.view
        let toView  : UIView = viewController.view
        if fromView == toView {
            return false
        }
        
        UIView.transition(from: fromView, to: toView, duration: durationOfTransition, options: .transitionCurlUp)
        return true
    }
   

}
