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
    
    static var walkthroughDimColor = UIColor.red.withAlphaComponent(0.7).cgColor
    
    var customWalkthroughView: CustomWalkthroughView? { return walkthroughView as? CustomWalkthroughView }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
        surnameField.delegate = self
        addressField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        customWalkthroughView?.cutHolesForViewDescriptors([ViewDescriptor(view: photo, extraPaddingX: 20, extraPaddingY: 20, cornerRadius: 80)])
        
        customWalkthroughView?.helpLabel.isHidden = false
        customWalkthroughView?.helpLabel.backgroundColor = UIColor.blue
        customWalkthroughView?.helpLabel.text = "Ok, lets play with the colors too! Tap the image to start."
        customWalkthroughView?.helpLabel.frame = CGRect(x: customWalkthroughView!.center.x - 150, y: customWalkthroughView!.center.y + 60, width: 300, height: 80)
    }
    
    @IBAction func onTapImage(_ sender: UITapGestureRecognizer) {
        customWalkthroughView?.cutHolesForViews([nameField])
        customWalkthroughView?.dimColor = UIColor.blue.withAlphaComponent(0.5).cgColor
        
        customWalkthroughView?.helpLabel.backgroundColor = UIColor.black
        customWalkthroughView?.helpLabel.text = "Now tell us your name"
        customWalkthroughView?.helpLabel.frame = CGRect(x: customWalkthroughView!.center.x - 150, y: customWalkthroughView!.center.y + 60, width: 300, height: 80)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let input = textField.text {
            return !input.isEmpty
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
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
            customWalkthroughView?.helpLabel.isHidden = true
            
            UserDefaults.standard.set(true, forKey: "profileWalkthroughComplete")
            
            if ongoingWalkthrough {
                navigationController?.popToRootViewController(animated: true)
            }
        }
    }

}
