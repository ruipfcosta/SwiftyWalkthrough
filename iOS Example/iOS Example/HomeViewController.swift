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
    
    lazy var walkthroughView: WalkthroughView = self.makeWalkthroughView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addWalkthroughView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let profileWalkthroughComplete = defaults.boolForKey("profileWalkthroughComplete")
        let settingsWalkthroughComplete = defaults.boolForKey("settingsWalkthroughComplete")
        
        if !profileWalkthroughComplete && !settingsWalkthroughComplete {
            walkthroughView.hidden = false
            
            let descriptors = [
                ViewDescriptor(view: showProfileButton, extraPaddingX: 20, extraPaddingY: 10, cornerRadius: 10),
                ViewDescriptor(view: showSettingsButton.valueForKey("view") as! UIView, extraPaddingX: 5, extraPaddingY: 0, cornerRadius: 10)
            ]
            
            walkthroughView.cutHolesForViews(descriptors)
        } else if !profileWalkthroughComplete {
            walkthroughView.hidden = false
            walkthroughView.cutHoleForView(ViewDescriptor(view: showProfileButton, extraPaddingX: 20, extraPaddingY: 10, cornerRadius: 10))
        } else if !settingsWalkthroughComplete {
            walkthroughView.hidden = false
            walkthroughView.cutHoleForView(ViewDescriptor(view: showSettingsButton.valueForKey("view") as! UIView, extraPaddingX: 5, extraPaddingY: 0, cornerRadius: 10))
        } else {
            walkthroughView.hidden = true
            walkthroughView.removeFromSuperview()
            print("Congratulations, walkthrough complete!")
            
            let alert = UIAlertController(title: "Congratulations", message: "All tutorials are now complete (restart the app to repeat)!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func makeWalkthroughView() -> WalkthroughView {
        let v = WalkthroughView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.hidden = true
        
        return v
    }
    
    func addWalkthroughView() {
        let views = ["walkthroughView": walkthroughView]
        
        navigationController?.view.addSubview(walkthroughView)
        navigationController?.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[walkthroughView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        navigationController?.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[walkthroughView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }
    
    @IBAction func settingsPressed(sender: UIBarButtonItem) {
        walkthroughView.removeAllHoles()
        performSegueWithIdentifier("settingsSegue", sender: sender)
    }
    
    @IBAction func profilePressed(sender: AnyObject) {
        walkthroughView.removeAllHoles()
        performSegueWithIdentifier("profileSegue", sender: sender)
    }

}

