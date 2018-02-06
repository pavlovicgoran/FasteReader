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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ac = UIAlertController(title: "\(bookToDisplay.getAuthor()) - \(bookToDisplay.getTitle()) Chapter \(indexPath.row + 1) Loaded", message: nil, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: {[unowned self](alert: UIAlertAction!) in
            
            self.navigationController?.popViewController(animated: true)
            
        }))
        
        present(ac, animated: true)
        
    }
    
}





