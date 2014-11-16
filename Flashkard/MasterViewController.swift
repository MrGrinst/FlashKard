//
//  MasterViewController.swift
//  Flashkard
//
//  Created by Luke Newman on 11/15/14.
//  Copyright (c) 2014 Luke Newman. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    var arr : [String] = []
    
    var decks: [Deck] = []

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func editDeck(sender: AnyObject) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let deck = decks[indexPath.row]
            (segue.destinationViewController as DetailViewController).detailItem = deck
            }
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decks.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        cell.textLabel.text = decks[indexPath.row].name
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            deleteDeck(indexPath)
        } else if editingStyle == .Insert {
            insertDeck()
        }
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}

