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
    
    var customWalkthroughView: CustomWalkthroughView? { return walkthroughView as? CustomWalkthroughView }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        customWalkthroughView?.cutHolesForViews([segmented])
            
        customWalkthroughView?.helpLabel.isHidden = false
        customWalkthroughView?.helpLabel.text = "Right, lets change that segmented control value"
        customWalkthroughView?.helpLabel.frame = CGRect(x: customWalkthroughView!.center.x - 150, y: customWalkthroughView!.center.y + 60, width: 300, height: 80)
    }
    
    @IBAction func segmentedValueChanged(_ sender: UISegmentedControl) {
        customWalkthroughView?.cutHolesForViews([slider])
        customWalkthroughView?.helpLabel.text = "Cool, now drag the slider all the way to the right"
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        if sender.value == sender.maximumValue {
            customWalkthroughView?.cutHolesForViews([switchView])
            customWalkthroughView?.helpLabel.text = "To finish, change that switch value!"
        }
    }
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        customWalkthroughView?.removeAllHoles()
        customWalkthroughView?.helpLabel.isHidden = true
        
        UserDefaults.standard.set(true, forKey: "settingsWalkthroughComplete")
        
        if ongoingWalkthrough {
            dismiss(animated: true)
        }
    }
    
}
