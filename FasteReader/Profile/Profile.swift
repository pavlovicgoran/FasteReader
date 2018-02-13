//
//  Profile.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/12/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import UIKit
// Singleton
class Profile: NSObject {
    
    private let minimumWPM = 250
    private let maximumWPM = 750
    
    private var username = ""
    private var wordsPerMinute = 250
    private var numberOfLines = 1
    private var lineLength = 1
    
    private var profileImage: UIImage?
    
    static let sharedInstance = Profile()
    private override init() {}
    
    
    
}


// MARK: Getters and Setters
extension Profile{
    
    public func setUsername(username: String){
        self.username = username
    }
    
    public func getUsername() -> String{
        return username
    }
    
    public func getWordsPerMinute() -> Int{
        return wordsPerMinute
    }
    
    public func setWordsPerMinute(wpm: Int){
        guard (wpm >= minimumWPM && wpm <= maximumWPM) else {
            return
        }
        self.wordsPerMinute = wpm
    }
    
    public func getNumberOfLines() -> Int{
        return numberOfLines
    }
    
    public func setNumberOfLines(numberOfLines: Int){
        self.numberOfLines = numberOfLines
    }
    
    public func getLineLength() -> Int{
        return lineLength
    }
    
    public func setLineLength(lineLength: Int){
        self.lineLength = lineLength
    }
    
    public func getProfileImage() -> UIImage?{
        return profileImage
    }
    
    public func setProfileImage(image: UIImage){
        self.profileImage = image
    }
}




