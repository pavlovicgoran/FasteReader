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
    
    private var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialazeArrayOfColors()
        initializeBooksArray()
    }

    
    private func initialazeArrayOfColors(){
        arrayOfColors.append(blackBookCover)
        arrayOfColors.append(redBookCover)
        arrayOfColors.append(brownBookCover)
    }

    private func initializeBooksArray(){
        books.append(Book(author: "Chip Heath", title: "Made to Stick", prefix: .madeToStick))
        books.append(Book(author: "Dan Brown", title: "Origin", prefix: .origin))
        books.append(Book(author: "Ed Catmul", title: "Creativity Inc", prefix: .creativity))
        books.append(Book(author: "Janson Hanson", title: "Spy Secrets", prefix: .spy))
        books.append(Book(author: "Josh Waitzkin", title: "The Art of Learning", prefix: .artOfLearning))
        books.append(Book(author: "Marcus Chown", title: "Quantum Theory", prefix: .quantumTheory))
        books.append(Book(author: "Seneca", title: "Piece of Mind", prefix: .pieceOfMind))
    }

}

// MARK: UICollectionViewController

extension LibraryCollectionViewController{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return books.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BookCell
        
        // Configure the cell
        let book = books[indexPath.item]
        
        cell.bookCover.image = getBookCoverImage()
        cell.author.text = book.getAuthor()
        
        cell.title.text = book.getTitle()
        
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




