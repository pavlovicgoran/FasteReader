//
//  TechniquesTextArea.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/9/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import Foundation


class ToolsDescription{
    
    private let wordFlashFile = ""
    private let diamondHighlighterFile = ""
    private let textHighlighterFile = ""
    private let expandVisionFile = ""
    
    static var wordFlashDescription = "WORD FLASH"
    static var diamondHighlighterDescription = "DIAMOND HIGHLIGHTER"
    static var textHighlighterDescription = "TEXT HIGHLIGHTER"
    static var expandVisionDescription = "EXPAND VISION"
    
    static func populateDescriptions(){
        populateDescription(tool: .wordFlash)
        populateDescription(tool: .diamond)
        populateDescription(tool: .textHighlight)
        populateDescription(tool: .extendVision)
    }
    
    private static func populateDescription(tool: ToolbarIdentifier){
        
        switch tool {
        case .wordFlash:
            break
        case .diamond:
            break
        case .textHighlight:
            break
        case .extendVision:
            break
        default:
            print("Tool description another tool exists!!!")
        }
        
    }
}
