//
//  LibraryViewControllerCollectionViewController.swift
//  FasteReader
//
//  Created by Goran Pavlovic on 2/4/18.
//  Copyright © 2018 Goran Pavlovic. All rights reserved.
//

import UIKit
import GameplayKit

// MARK: Properties and Initialization
class LibraryCollectionViewController: UICollectionViewController{

    private let reuseIdentifier = "Book"
    private let blackBookCover = "book_cover_black"
    private let redBookCover = "book_cover_red"
    private let brownBookCover = "book_cover_brown"
    
    private var arrayOfColors = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialazeArrayOfColors()
        
    }

    
    private func initialazeArrayOfColors(){
        arrayOfColors.append(blackBookCover)
        arrayOfColors.append(redBookCover)
        arrayOfColors.append(brownBookCover)
    }


}

// MARK: UICollectionViewController

extension LibraryCollectionViewController{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BookCell
        
        // Configure the cell
        
        cell.bookCover.image = getBookCoverImage()
        cell.author.text = "Rango"
        
        cell.title.text = "Orlovi rano lete"
        
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
    
}




