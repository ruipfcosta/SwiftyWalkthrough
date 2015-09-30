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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if let wt = attachToWalkthrough() {
            wt.cutHolesForViews([segmented])
            navigationController?.interactivePopGestureRecognizer?.enabled = false
            
            customizedSubview?.helpLabel.hidden = false
            customizedSubview?.helpLabel.text = "Right, lets change that segmented control value"
            customizedSubview?.helpLabel.frame = CGRect(x: customizedSubview!.center.x - 150, y: customizedSubview!.center.y + 60, width: 300, height: 80)
            
        } else {
            navigationController?.interactivePopGestureRecognizer?.enabled = true
        }
    }
    
    @IBAction func segmentedValueChanged(sender: UISegmentedControl) {
        walkthroughView?.cutHolesForViews([slider])
        customizedSubview?.helpLabel.text = "Cool, now drag the slider all the way to the right"
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        if sender.value == sender.maximumValue {
            walkthroughView?.cutHolesForViews([switchView])
            customizedSubview?.helpLabel.text = "To finish, change that switch value!"
        }
    }
    
    @IBAction func switchValueChanged(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "settingsWalkthroughComplete")
        
        if let wt = walkthroughView {
            wt.removeAllHoles()
            customizedSubview?.helpLabel.hidden = true
            navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
}
