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
    var walkthroughView: WalkthroughView?
    var walkthroughActive = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
        surnameField.delegate = self
        addressField.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        walkthroughActive = attachToWalkthrough()
        
        if walkthroughActive {
            walkthroughView?.cutHolesForViewDescriptors([ViewDescriptor(view: photo, extraPaddingX: 20, extraPaddingY: 20, cornerRadius: 80)])
        }
        
        // Disable navigation controller back swipe gesture
        if let recognizer = navigationController?.interactivePopGestureRecognizer {
            recognizer.enabled = !walkthroughActive
        }
    }
    
    func attachToWalkthrough() -> Bool {
        if let navSubviews = navigationController?.view.subviews {
            for navSub in navSubviews {
                if let navSub = navSub as? WalkthroughView {
                    walkthroughView = navSub
                    return true
                }
            }
        }
        
        return false
    }
    
    @IBAction func onTapImage(sender: UITapGestureRecognizer) {
        if walkthroughActive {
            walkthroughView?.cutHolesForViews([nameField])
        }
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
        } else if textField == surnameField {
            walkthroughView?.cutHolesForViews([addressField])
        } else if textField == addressField {
            walkthroughView?.dimColor = HomeViewController.walkthroughDimColor
            walkthroughView?.removeAllHoles()
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "profileWalkthroughComplete")
            navigationController?.popToRootViewControllerAnimated(true)
        }
    }

}
