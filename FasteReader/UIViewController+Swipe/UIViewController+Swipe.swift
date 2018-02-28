//
//  UIViewController+Swipe.swift .swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/28/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    @objc func handleSwipe(swipe: UISwipeGestureRecognizer){
        switch swipe.direction.rawValue {
        
        case UISwipeGestureRecognizerDirection.left.rawValue:
            
            if let tabBarCtrl = tabBarController as? BookTabController{
                let index = tabBarCtrl.selectedIndex + 1
                tabBarCtrl.beginTransition(tabBarCtrl, shouldSelect: (tabBarCtrl.viewControllers?[index])!, duration: BookTabController.longDurationOfTransition)
                tabBarCtrl.selectedIndex = index
            }
            
            break
        
        case UISwipeGestureRecognizerDirection.right.rawValue:
            
            if let tabBarCtrl = tabBarController as? BookTabController{
                let index = tabBarCtrl.selectedIndex - 1
                tabBarCtrl.beginTransition(tabBarCtrl, shouldSelect: (tabBarCtrl.viewControllers?[index])!, duration: BookTabController.longDurationOfTransition)
                tabBarCtrl.selectedIndex = index
            }
            
            break
        
        default:
            print("User swiped up or down")
        }
    }
    
}
