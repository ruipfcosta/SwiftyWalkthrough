//
//  ProfileViewController.swift
//  iOS Example
//
//  Created by Rui Costa on 29/09/2015.
//  Copyright © 2015 Rui Costa. All rights reserved.
//

import UIKit
import SwiftyWalkthrough

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    
    static var walkthroughDimColor = UIColor.redColor().colorWithAlphaComponent(0.7).CGColor
    
    var customWalkthroughView: CustomWalkthroughView? { return walkthroughView as? CustomWalkthroughView }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
        surnameField.delegate = self
        addressField.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        customWalkthroughView?.cutHolesForViewDescriptors([ViewDescriptor(view: photo, extraPaddingX: 20, extraPaddingY: 20, cornerRadius: 80)])
        
        customWalkthroughView?.helpLabel.hidden = false
        customWalkthroughView?.helpLabel.backgroundColor = UIColor.blueColor()
        customWalkthroughView?.helpLabel.text = "Ok, lets play with the colors too! Tap the image to start."
        customWalkthroughView?.helpLabel.frame = CGRect(x: customWalkthroughView!.center.x - 150, y: customWalkthroughView!.center.y + 60, width: 300, height: 80)
    }
    
    @IBAction func onTapImage(sender: UITapGestureRecognizer) {
        customWalkthroughView?.cutHolesForViews([nameField])
        customWalkthroughView?.dimColor = UIColor.blueColor().colorWithAlphaComponent(0.5).CGColor
        
        customWalkthroughView?.helpLabel.backgroundColor = UIColor.blackColor()
        customWalkthroughView?.helpLabel.text = "Now tell us your name"
        customWalkthroughView?.helpLabel.frame = CGRect(x: customWalkthroughView!.center.x - 150, y: customWalkthroughView!.center.y + 60, width: 300, height: 80)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if let input = textField.text {
            return !input.isEmpty
        }
        return false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == nameField {
            customWalkthroughView?.cutHolesForViews([surnameField])
            customWalkthroughView?.helpLabel.text = "... and the surname"
            customWalkthroughView?.helpLabel.frame = CGRect(x: customWalkthroughView!.center.x - 150, y: 60, width: 300, height: 80)
        } else if textField == surnameField {
            customWalkthroughView?.cutHolesForViews([addressField])
            customWalkthroughView?.dimColor = ProfileViewController.walkthroughDimColor
            customWalkthroughView?.helpLabel.text = "... and finally your address!"
        } else if textField == addressField {
            customWalkthroughView?.dimColor = HomeViewController.walkthroughDimColor
            customWalkthroughView?.removeAllHoles()
            customWalkthroughView?.helpLabel.hidden = true
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "profileWalkthroughComplete")
            
            if ongoingWalkthrough {
                navigationController?.popToRootViewControllerAnimated(true)
            }
        }
    }

}
