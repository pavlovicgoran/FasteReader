//
//  LibraryViewControllerCollectionViewController.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/4/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import UIKit
import GameplayKit


class LibraryViewControllerCollectionViewController: UICollectionViewController {

    private let reuseIdentifier = "Book"
    private let blackBookCover = "book_cover_black"
    private let redBookCover = "book_cover_red"
    private let brownBookCover = "book_cover_brown"
    
    private var arrayOfColors = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialazeArrayOfColors()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    // MARK: Collection view
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BookCell
    
        // Configure the cell
        
        cell.bookCover.image = getBookCoverImage()
    
        return cell
    }
    
    private func getBookCoverImage() -> UIImage{
        let color = chooseColorOfBookCover()
        let bookCover = UIImage(named: color)!
        return bookCover
    }
    
    private func chooseColorOfBookCover() -> String{
        arrayOfColors = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: arrayOfColors) as! [String]
        return arrayOfColors[0]
    }
    
    private func initialazeArrayOfColors(){
        arrayOfColors.append(blackBookCover)
        arrayOfColors.append(redBookCover)
        arrayOfColors.append(brownBookCover)
    }


}
