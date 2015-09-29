//
//  SettingsViewController.swift
//  iOS Example
//
//  Created by Rui Costa on 29/09/2015.
//  Copyright © 2015 Rui Costa. All rights reserved.
//

import UIKit
import SwiftyWalkthrough

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var switchView: UISwitch!
    
    var walkthroughView: WalkthroughView?
    var walkthroughActive = false
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        walkthroughActive = attachToOnBoarding()
        
        if walkthroughActive {
            walkthroughView?.cutHoleForView(ViewDescriptor(view: segmented))
        }
        
        // Disable navigation controller back swipe gesture
        if let recognizer = navigationController?.interactivePopGestureRecognizer {
            recognizer.enabled = !walkthroughActive
        }
    }
    
    func attachToOnBoarding() -> Bool {
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
    
    @IBAction func segmentedValueChanged(sender: UISegmentedControl) {
        walkthroughView?.cutHolesForViews([ViewDescriptor(view: slider)])
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        if sender.value == sender.maximumValue {
            walkthroughView?.cutHolesForViews([ViewDescriptor(view: switchView)])
        }
    }
    
    @IBAction func switchValueChanged(sender: UISwitch) {
        walkthroughView?.removeAllHoles()
        
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "settingsWalkthroughComplete")
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
}

