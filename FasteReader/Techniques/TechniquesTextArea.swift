//
//  TechniquesTextArea.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/9/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import Foundation


class ToolsDescription{
    
    private static let wordFlashFile = "word_flash_description"
    private static let diamondHighlighterFile = "diamond_description"
    private static let textHighlighterFile = "text_highlighter_description"
    private static let expandVisionFile = "expand_vision_description"
    
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
            
            wordFlashDescription = loadDescription(fileName: wordFlashFile)
            
            break
        case .diamond:
            diamondHighlighterDescription = loadDescription(fileName: diamondHighlighterFile)
            
            break
        case .textHighlight:
            textHighlighterDescription = loadDescription(fileName: textHighlighterFile)
            
            break
        case .extendVision:
            expandVisionDescription = loadDescription(fileName: expandVisionFile)
            break
        default:
            print("Populate - Tool description another tool exists!!!")
        }
        
    }
    
    private static func loadDescription(fileName: String) -> String{
        if let path = Bundle.main.path(forResource: fileName, ofType: "txt"){
            if let description = try? String(contentsOfFile: path){
                return description
            }
        }
        return "Load descrpition - something went wrong"
    }
    
   
    
}





