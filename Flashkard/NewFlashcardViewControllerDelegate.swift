//
//  NewFlashcardViewControllerProtocol.swift
//  Flashkard
//
//  Created by Luke Newman on 11/16/14.
//  Copyright (c) 2014 Luke Newman. All rights reserved.
//

import Foundation

protocol NewFlashcardViewControllerDelegate {
    func newFlashcardViewControllerDidCreateFlashcardSuccessfully(card: Card)
}