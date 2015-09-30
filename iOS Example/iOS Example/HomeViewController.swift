//
//  HomeViewController.swift
//  iOS Example
//
//  Created by Rui Costa on 28/09/2015.
//  Copyright © 2015 Rui Costa. All rights reserved.
//

import UIKit
import SwiftyWalkthrough

class HomeViewController: UIViewController {
    
    @IBOutlet weak var showProfileButton: UIButton!
    @IBOutlet weak var showSettingsButton: UIBarButtonItem!
    
    static var walkthroughDimColor = UIColor.blackColor().colorWithAlphaComponent(0.5).CGColor
    
    lazy var customizedSubview: CustomWalkthroughSubview = self.makeCustomWalkthroughSubview()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = attachToWalkthrough() {
            print("Attached to existing walkthrough")
        } else {
            print("Walkthrough initialized!")
            initWalkthrough()
        }
        
        customizeWalkthroughView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let profileWalkthroughComplete = defaults.boolForKey("profileWalkthroughComplete")
        let settingsWalkthroughComplete = defaults.boolForKey("settingsWalkthroughComplete")
        
        // reset subview colors
        customizedSubview.helpLabel.backgroundColor = UIColor.redColor()
        customizedSubview.helpLabel.textColor = UIColor.whiteColor()
        
        if !profileWalkthroughComplete && !settingsWalkthroughComplete {
            let descriptors = [
                ViewDescriptor(view: showProfileButton, extraPaddingX: 20, extraPaddingY: 10, cornerRadius: 10),
                ViewDescriptor(view: showSettingsButton.valueForKey("view") as! UIView, extraPaddingX: 5, extraPaddingY: 0, cornerRadius: 10)
            ]
            
            walkthroughView?.cutHolesForViewDescriptors(descriptors)
            customizedSubview.helpLabel.hidden = false
            customizedSubview.helpLabel.text = "Hi, welcome to SwiftyWalkthrough!\nEdit your profile or go to settings."
            customizedSubview.helpLabel.frame = CGRect(x: customizedSubview.center.x - 150, y: customizedSubview.center.y + 60, width: 300, height: 80)
            
        } else if !profileWalkthroughComplete {
            
            walkthroughView?.cutHolesForViewDescriptors([ViewDescriptor(view: showProfileButton, extraPaddingX: 20, extraPaddingY: 10, cornerRadius: 10)])
            customizedSubview.helpLabel.hidden = false
            customizedSubview.helpLabel.text = "↑\nOk, only the profile left now! Tap \"Edit profile\" and have a look"
            customizedSubview.helpLabel.frame = CGRect(x: customizedSubview.center.x - 150, y: customizedSubview.center.y + 60, width: 300, height: 80)
            
        } else if !settingsWalkthroughComplete {
            
            walkthroughView?.cutHolesForViewDescriptors([ViewDescriptor(view: showSettingsButton.valueForKey("view") as! UIView, extraPaddingX: 5, extraPaddingY: 0, cornerRadius: 10)])
            customizedSubview.helpLabel.hidden = false
            customizedSubview.helpLabel.text = "Only settings left! Tap \"Settings\" right there ↗"
            customizedSubview.helpLabel.frame = CGRect(x: customizedSubview.center.x - 150, y: 60, width: 300, height: 80)
            
        } else {
            finishWalkthrough()
            showAlertMessage()
        }
    }
    
    func makeCustomWalkthroughSubview() -> CustomWalkthroughSubview {
        let v = CustomWalkthroughSubview()
        v.translatesAutoresizingMaskIntoConstraints = false
        
        return v
    }
    
    func customizeWalkthroughView() {
        if let wt = walkthroughView {
            wt.addSubview(customizedSubview)
            
            let views = ["customizedSubview": customizedSubview]
            wt.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[customizedSubview]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
            wt.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[customizedSubview]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        }
    }
        
    func showAlertMessage() {
        let alert = UIAlertController(title: "Congratulations", message: "All tutorials are now complete (restart the app to repeat)!", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func settingsPressed(sender: UIBarButtonItem) {
        walkthroughView?.removeAllHoles()
        customizedSubview.helpLabel.hidden = true
        performSegueWithIdentifier("settingsSegue", sender: sender)
    }
    
    @IBAction func profilePressed(sender: AnyObject) {
        walkthroughView?.dimColor = ProfileViewController.walkthroughDimColor
        walkthroughView?.removeAllHoles()
        customizedSubview.helpLabel.hidden = true
        performSegueWithIdentifier("profileSegue", sender: sender)
    }
    
    // WalkthroughViewDelegate
    
    func willInteractWithView(view: UIView) {
        print("Will interact with view \(view)")
    }
    
}

