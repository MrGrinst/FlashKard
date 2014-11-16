//
//  CoreDataManager.swift
//  Flashkard
//
//  Created by Kyle Grinstead on 11/15/14.
//  Copyright (c) 2014 Luke Newman. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    class var sharedInstance: CoreDataManager {
        struct Static {
            static let instance: CoreDataManager = CoreDataManager()
        }
        return Static.instance
    }
    
    func saveContext() {
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appDelegate.saveContext()
    }
    
    func createNewDeck(name: String) -> Deck {
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var context = appDelegate.managedObjectContext!
        var deck = NSEntityDescription.insertNewObjectForEntityForName("Deck", inManagedObjectContext: context) as Deck
        
        deck.name = name
        
        self.saveContext()
        
        return deck
    }
    
    func createNewCard() -> Card {
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var context = appDelegate.managedObjectContext!
        var card = NSEntityDescription.insertNewObjectForEntityForName("Card", inManagedObjectContext: context) as Card
        
        self.saveContext()
        
        return card
    }
    
    func deleteDeck(deck: Deck) {
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var context = appDelegate.managedObjectContext!
        
        context.deleteObject(deck)
        
        self.saveContext()
    }
    
    func deleteCard(card: Card) {
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var context = appDelegate.managedObjectContext!
        
        context.deleteObject(card)
        
        self.saveContext()
    }
    
    func fetchDecks() -> [Deck] {
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var context = appDelegate.managedObjectContext!
        
        var entityDescription = NSEntityDescription.entityForName("Deck", inManagedObjectContext: context)
        var request = NSFetchRequest()
        request.entity = entityDescription
        
        var error: NSError?
        let decks = context.executeFetchRequest(request, error: &error)
        
        return decks! as [Deck]
    }
    
    func fetchCards(deck: Deck) -> [Card] {
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var context = appDelegate.managedObjectContext!
        
        var entityDescription = NSEntityDescription.entityForName("Card", inManagedObjectContext: context)
        var request = NSFetchRequest(entityName: "")
        var predicate = NSPredicate(format: "deck = %@", deck)
        request.entity = entityDescription
        request.predicate = predicate
        
        var error: NSError?
        let cards = context.executeFetchRequest(request, error: &error)
        
        return cards! as [Card]
    }
    
}