//
//  Deck.swift
//  Flashkard
//
//  Created by Kyle Grinstead on 11/15/14.
//  Copyright (c) 2014 Luke Newman. All rights reserved.
//

import Foundation
import CoreData

@objc(Deck)
class Deck: NSManagedObject {
    @NSManaged var name: String
}