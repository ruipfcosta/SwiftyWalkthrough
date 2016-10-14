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
    
    static var walkthroughDimColor = UIColor.black.withAlphaComponent(0.5).cgColor
    
    var customWalkthroughView: CustomWalkthroughView? { return walkthroughView as? CustomWalkthroughView }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ongoingWalkthrough {
            print("Attached to existing walkthrough")
        } else {
            print("Walkthrough initialized!")
            startWalkthrough(CustomWalkthroughView())
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let defaults = UserDefaults.standard
        let profileWalkthroughComplete = defaults.bool(forKey: "profileWalkthroughComplete")
        let settingsWalkthroughComplete = defaults.bool(forKey: "settingsWalkthroughComplete")
        
        // reset subview colors
        customWalkthroughView?.helpLabel.backgroundColor = UIColor.red
        customWalkthroughView?.helpLabel.textColor = UIColor.white
        
        if !profileWalkthroughComplete && !settingsWalkthroughComplete {
            let descriptors = [
                ViewDescriptor(view: showProfileButton, extraPaddingX: 20, extraPaddingY: 10, cornerRadius: 10),
                ViewDescriptor(view: showSettingsButton.value(forKey: "view") as! UIView, extraPaddingX: 5, extraPaddingY: 0, cornerRadius: 10)
            ]
            
            walkthroughView?.cutHolesForViewDescriptors(descriptors)
            customWalkthroughView?.helpLabel.isHidden = false
            customWalkthroughView?.helpLabel.text = "Hi, welcome to SwiftyWalkthrough!\nEdit your profile or go to settings."
            customWalkthroughView?.helpLabel.frame = CGRect(x: customWalkthroughView!.center.x - 150, y: customWalkthroughView!.center.y + 60, width: 300, height: 80)
            
        } else if !profileWalkthroughComplete {
            
            walkthroughView?.cutHolesForViewDescriptors([ViewDescriptor(view: showProfileButton, extraPaddingX: 20, extraPaddingY: 10, cornerRadius: 10)])
            customWalkthroughView?.helpLabel.isHidden = false
            customWalkthroughView?.helpLabel.text = "↑\nOk, only the profile left now! Tap \"Edit profile\" and have a look"
            customWalkthroughView?.helpLabel.frame = CGRect(x: customWalkthroughView!.center.x - 150, y: customWalkthroughView!.center.y + 60, width: 300, height: 80)
            
        } else if !settingsWalkthroughComplete {
            
            walkthroughView?.cutHolesForViewDescriptors([ViewDescriptor(view: showSettingsButton.value(forKey: "view") as! UIView, extraPaddingX: 5, extraPaddingY: 0, cornerRadius: 10)])
            customWalkthroughView?.helpLabel.isHidden = false
            customWalkthroughView?.helpLabel.text = "Only settings left! Tap \"Settings\" right there ↗"
            customWalkthroughView?.helpLabel.frame = CGRect(x: customWalkthroughView!.center.x - 150, y: 60, width: 300, height: 80)
            
        } else {
            finishWalkthrough()
            showAlertMessage()
        }
    }
    
    func showAlertMessage() {
        let alert = UIAlertController(title: "Congratulations", message: "All tutorials are now complete (restart the app to repeat)!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func settingsPressed(_ sender: UIBarButtonItem) {
        customWalkthroughView?.removeAllHoles()
        customWalkthroughView?.helpLabel.isHidden = true
        performSegue(withIdentifier: "settingsSegue", sender: sender)
    }
    
    @IBAction func profilePressed(_ sender: AnyObject) {
        customWalkthroughView?.dimColor = ProfileViewController.walkthroughDimColor
        customWalkthroughView?.removeAllHoles()
        customWalkthroughView?.helpLabel.isHidden = true
        performSegue(withIdentifier: "profileSegue", sender: sender)
    }
    
    // WalkthroughViewDelegate
    
    func willInteractWithView(_ view: UIView) {
        print("Will interact with view \(view)")
    }
    
}

