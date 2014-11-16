//
//  MasterViewController.swift
//  Flashkard
//
//  Created by Luke Newman on 11/15/14.
//  Copyright (c) 2014 Luke Newman. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var decks: [Deck] = []

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func newNote(sender: AnyObject) {
        insertDeck()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        decks = CoreDataManager.sharedInstance.fetchDecks()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertDeck() {
        var inputTextField: UITextField?
        let passwordPrompt = UIAlertController(title: "Deck Name", message: "What would you like to name this deck?", preferredStyle: UIAlertControllerStyle.Alert)
        passwordPrompt.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            var deck = CoreDataManager.sharedInstance.createNewDeck(inputTextField!.text)
            self.decks.insert(deck, atIndex: 0)
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }))
        passwordPrompt.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Name"
            inputTextField = textField
        })
        
        presentViewController(passwordPrompt, animated: true, completion: nil)

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

    // MARK: - Table View

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
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            var deck = decks.removeAtIndex(indexPath.row)
            CoreDataManager.sharedInstance.deleteDeck(deck)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            insertDeck()
        }
    }


}

