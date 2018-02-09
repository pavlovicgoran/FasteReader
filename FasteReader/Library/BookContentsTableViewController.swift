//
//  BookContentsTableViewController.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/6/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import UIKit

// MARK: Properties and Initialization

class BookContentsTableViewController: UITableViewController {
    
    let numberOfAvailableChapters = 6
    private let cellIdentifier = "BookChapter"

    var bookToDisplay: Book!
    
    var bookContents = [String]();
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "\(bookToDisplay.getAuthor()) - \(bookToDisplay.getTitle())"
        
        initialazeBookContentsArray()
    }
    
    private func initialazeBookContentsArray(){
        
        for i in 0 ..< numberOfAvailableChapters{
            
            bookContents.append("Chapter \(i + 1)")
            
        }
        
    }

}

// MARK: UITableViewController

extension BookContentsTableViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookContents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let chapter = bookContents[indexPath.row]
        
        cell.textLabel?.text = chapter
        
        return cell
    }
    
    // MARK : FILL - LOADING BOOK CHAPTER INTO A CLASS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        setReadingChapter(chapterNumber: (indexPath.row + 1))
        
        let ac = UIAlertController(title: "\(bookToDisplay.getAuthor()) - \(bookToDisplay.getTitle()) Chapter \(indexPath.row + 1) Loaded", message: nil, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: {[unowned self](alert: UIAlertAction!) in
            
            
            self.navigationController?.popViewController(animated: true)
            self.tabBarController?.selectedIndex = 1
            
        }))
        
        present(ac, animated: true)
        
    }
    
    private func setReadingChapter(chapterNumber: Int){
        var chapter = ""
        BookChapter.setChapterNumber(chapterNumber: chapterNumber)
        
        switch bookToDisplay.getPrefix() {
        case .madeToStick:
            chapter = "\(availableBookTitles.madeToStick.rawValue) Chapter \(chapterNumber)"
            BookChapter.setBook(book: .madeToStick)
            
        case .creativity:
            chapter = "\(availableBookTitles.creativity.rawValue) Chapter \(chapterNumber)"
            BookChapter.setBook(book: .creativity)
            
        case .artOfLearning:
            chapter = "\(availableBookTitles.artOfLearning.rawValue) Chapter \(chapterNumber)"
            BookChapter.setBook(book: .artOfLearning)
            
        case .origin:
            chapter = "\(availableBookTitles.origin.rawValue) Chapter \(chapterNumber)"
            BookChapter.setBook(book: .origin)
            
        case .pieceOfMind:
            chapter = "\(availableBookTitles.pieceOfMind.rawValue) Chapter \(chapterNumber)"
            BookChapter.setBook(book: .pieceOfMind)
            
        case .quantumTheory:
            chapter = "\(availableBookTitles.quantumTheory.rawValue) Chapter \(chapterNumber)"
            BookChapter.setBook(book: .quantumTheory)
            
        case .spy:
            chapter = "\(availableBookTitles.spy.rawValue) Chapter \(chapterNumber)"
            BookChapter.setBook(book: .spy)
            
        default:
           print("Book contents selection - there are more books")
        }
        
        chapter = "Reading: \(chapter)"
        BookChapter.currentlyReading = chapter
        
        updateReadingButtonOnTechniquesView()
        
    }
    
    private func updateReadingButtonOnTechniquesView(){
        //gets navigation controller of Techniques view
        let navController = tabBarController?.viewControllers?[1] as! UINavigationController
        
        //gets techniques view controller from navigation controller
        let tvc = navController.viewControllers[0] as! TechniquesViewController
        
        //update Reading button
        tvc.updateReadingMaterial()
    }
    
    
    
}










