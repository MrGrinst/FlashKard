//
//  DetailViewController.swift
//  Flashkard
//
//  Created by Luke Newman on 11/15/14.
//  Copyright (c) 2014 Luke Newman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, NewFlashcardViewControllerDelegate {
    var arr : [Card] = []
    var name: AnyObject? {
        get {
            return NSUserDefaults.standardUserDefaults().objectForKey("name")
        }
        set {
            NSUserDefaults.standardUserDefaults().setObject(newValue!, forKey: "name")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    @IBAction func didTapNewFlashcardButton(sender: AnyObject) {
        var newFlashcardVC: NewFlashcardViewController = NewFlashcardViewController()
        newFlashcardVC.delegate = self;
        self.presentViewController(newFlashcardVC, animated: true, completion: { () -> Void in
            NSLog("modal completion finished")
        })
    }
    
    func newFlashcardViewControllerDidCreateFlashcardSuccessfully(card: Card) {
        arr.append(card)
        //collectionView(collectionView: UICollectionView reloadData(self))
    }

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            self.title = detail.name
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        if let detail: AnyObject = self.detailItem {
            arr = CoreDataManager.sharedInstance.fetchCards(detail as Deck)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as myViewCell
        cell.imgView.image = UIImage(data: arr[indexPath.row].frontImage)
        return cell
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        name = arr[indexPath.row]
    }
}
