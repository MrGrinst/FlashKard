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
    var name: AnyObject? {
        get {
            return NSUserDefaults.standardUserDefaults().objectForKey("name")
        }
        set {
            NSUserDefaults.standardUserDefaults().setObject(newValue!, forKey: "name")
            
        }
    }
    
    var decks: [Deck] = []

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func newNote(sender: AnyObject) {
        insertDeck()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decks = CoreDataManager.sharedInstance.fetchDecks().reverse()
        arr = ["notecard.png","notecard.png", "notecard.png"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func insertDeck() {
        var inputTextField: UITextField?
        let namePrompt = UIAlertController(title: "Deck Name", message: "What would you like to name this deck?", preferredStyle: UIAlertControllerStyle.Alert)
        namePrompt.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            if (inputTextField!.text.stringByReplacingOccurrencesOfString(" ", withString: "") == "") {
                self.presentViewController(namePrompt, animated: true, completion: nil)
            } else {
                var deck = CoreDataManager.sharedInstance.createNewDeck(inputTextField!.text)
                self.decks.insert(deck, atIndex: 0)
                let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }))
        namePrompt.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Name"
            inputTextField = textField
        })
        presentViewController(namePrompt, animated: true, completion: nil)
    }
    
    func deleteDeck(indexPath: NSIndexPath) {
        var deck = decks[indexPath.row]
        let deleteConfirm = UIAlertController(title: "Delete '" + deck.name + "' deck?" , message: "Are you sure you want to delete this deck?", preferredStyle: UIAlertControllerStyle.Alert)
        deleteConfirm.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: { (action) -> Void
            in
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        }))
        deleteConfirm.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            self.decks.removeAtIndex(indexPath.row)
            CoreDataManager.sharedInstance.deleteDeck(deck)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }))
        presentViewController(deleteConfirm, animated: true, completion: nil)
    }

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
        return arr.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as myViewCell
        cell.imgView.image=UIImage(named: arr[indexPath.row])
        return cell
    
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        <#code#>
    }
    
}

