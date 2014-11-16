//
//  NewFlashcardViewController.swift
//  Flashkard
//
//  Created by Luke Newman on 11/16/14.
//  Copyright (c) 2014 Luke Newman. All rights reserved.
//

import Foundation
import UIKit

class NewFlashcardViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var frontImageButton: UIButton!
    @IBOutlet weak var backImageButton: UIButton!
    
    var delegate: NewFlashcardViewControllerDelegate!
    var activeButton: UIButton!
    var imagePicker: UIImagePickerController!
    
    @IBAction func didTapFrontPicture(sender: AnyObject) {
        activeButton = frontImageButton
        if (imagePicker == nil) {
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        }
        self.presentViewController(imagePicker, animated: true, completion: { imageP in })
    }
    
    @IBAction func didTapBackPicture(sender: AnyObject) {
        activeButton = backImageButton
        if (imagePicker == nil) {
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        }
        self.presentViewController(imagePicker, animated: true, completion: { imageP in })
    }
    
    @IBAction func didTapCancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didTapCreateButton(sender: AnyObject) {
        var card = Card()
        card.frontImage = UIImageJPEGRepresentation(frontImageButton.backgroundImageForState(UIControlState.Normal), 0.0)
        card.backImage = UIImageJPEGRepresentation(backImageButton.backgroundImageForState(UIControlState.Normal), 0.0)
        self.delegate.newFlashcardViewControllerDidCreateFlashcardSuccessfully(card)
    }
    
    func newFlashcardViewControllerDidCreateFlashcardSuccessfully(card: Card) {
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        activeButton.setBackgroundImage(info[UIImagePickerControllerOriginalImage] as? UIImage, forState: UIControlState.Normal)
        picker.dismissViewControllerAnimated(true, completion: { () -> Void in })
    }
}