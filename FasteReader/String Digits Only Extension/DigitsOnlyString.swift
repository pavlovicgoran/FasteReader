//
//  DigitsOnlyString.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/13/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import Foundation


extension String{
    
    func digitsOnly() -> String{
        let stringArray = self.components(separatedBy: CharacterSet.decimalDigits.inverted)
        let digitsOnly = stringArray.joined(separator: "")
        return digitsOnly
    }
}
