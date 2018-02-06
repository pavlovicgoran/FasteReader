//
//  BookContentsTableViewController.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/6/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import UIKit

class BookContentsTableViewController: UITableViewController {

    var bookToDisplay: Book!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "\(bookToDisplay.getAuthor()) - \(bookToDisplay.getTitle())"
    }

}
