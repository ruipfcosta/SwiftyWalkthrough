//
//  UIViewController+Walkthrough.swift
//  SwiftyWalkthrough
//
//  Created by Rui Costa on 29/09/2015.
//  Copyright © 2015 Rui Costa. All rights reserved.
//

import UIKit

extension UIViewController: WalkthroughViewDelegate {

    public var walkthroughView: WalkthroughView? {
        return attachToWalkthrough()
    }
    
    public var ongoingWalkthrough: Bool {
        return walkthroughView != .none
    }
    
    public func makeWalkthroughView() -> WalkthroughView {
        let v = WalkthroughView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }
    
    public func startWalkthrough(_ walkthroughView: WalkthroughView) {
        if ongoingWalkthrough {
            finishWalkthrough()
        }
        
        guard let window = UIApplication.shared.keyWindow else { return }
        
        walkthroughView.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["walkthroughView": walkthroughView]
        
        window.addSubview(walkthroughView)
        window.bringSubview(toFront: walkthroughView)
        
        window.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[walkthroughView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        window.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[walkthroughView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        window.setNeedsLayout()
    }
    
    public func attachToWalkthrough() -> WalkthroughView? {
        guard let window = UIApplication.shared.keyWindow else { return .none }
        
        for rootSubview in window.subviews {
            if let walkthrough = rootSubview as? WalkthroughView {
                walkthrough.delegate = self
                return walkthrough
            }
        }
        
        return .none
    }
    
    public func finishWalkthrough() {
        walkthroughView?.removeFromSuperview()
    }
    
}
