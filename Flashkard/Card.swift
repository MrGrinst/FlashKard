//
//  Card.swift
//  Flashkard
//
//  Created by Kyle Grinstead on 11/15/14.
//  Copyright (c) 2014 Luke Newman. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Card)
class Card: NSManagedObject {
    @NSManaged var frontImage: NSData
    @NSManaged var backImage: NSData
    @NSManaged var deck: Deck
}