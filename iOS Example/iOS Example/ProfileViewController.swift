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
    
    var customizedSubview: CustomWalkthroughSubview? {
        if let subviews = walkthroughView?.subviews {
            for subview in subviews {
                if let customized = subview as? CustomWalkthroughSubview {
                    return customized
                }
            }
        }
        return .None
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
        surnameField.delegate = self
        addressField.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        if let wt = attachToWalkthrough() {
            wt.cutHolesForViewDescriptors([ViewDescriptor(view: photo, extraPaddingX: 20, extraPaddingY: 20, cornerRadius: 80)])
            navigationController?.interactivePopGestureRecognizer?.enabled = false
            
            customizedSubview?.helpLabel.hidden = false
            customizedSubview?.helpLabel.backgroundColor = UIColor.blueColor()
            customizedSubview?.helpLabel.text = "Ok, lets play with the colors! By the way, tap the image to start."
            customizedSubview?.helpLabel.frame = CGRect(x: customizedSubview!.center.x - 150, y: customizedSubview!.center.y + 60, width: 300, height: 80)
            
        } else {
            navigationController?.interactivePopGestureRecognizer?.enabled = true
        }
    }
    
    @IBAction func onTapImage(sender: UITapGestureRecognizer) {
        walkthroughView?.cutHolesForViews([nameField])
        walkthroughView?.dimColor = UIColor.blueColor().colorWithAlphaComponent(0.5).CGColor
        
        customizedSubview?.helpLabel.backgroundColor = UIColor.blackColor()
        customizedSubview?.helpLabel.text = "Now tell us your name"
        customizedSubview?.helpLabel.frame = CGRect(x: customizedSubview!.center.x - 150, y: customizedSubview!.center.y + 60, width: 300, height: 80)
        
        nameField.becomeFirstResponder()
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
            walkthroughView?.cutHolesForViews([surnameField])
            customizedSubview?.helpLabel.text = "... and the surname"
            customizedSubview?.helpLabel.frame = CGRect(x: customizedSubview!.center.x - 150, y: 60, width: 300, height: 80)
            
            surnameField.becomeFirstResponder()
        } else if textField == surnameField {
            walkthroughView?.cutHolesForViews([addressField])
            walkthroughView?.dimColor = ProfileViewController.walkthroughDimColor
            customizedSubview?.helpLabel.text = "... and finally your address!"
            
            addressField.becomeFirstResponder()
        } else if textField == addressField {
            walkthroughView?.dimColor = HomeViewController.walkthroughDimColor
            walkthroughView?.removeAllHoles()
            customizedSubview?.helpLabel.hidden = true
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "profileWalkthroughComplete")
            navigationController?.popToRootViewControllerAnimated(true)
        }
    }

}
