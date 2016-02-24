//
//  UIViewController+Walkthrough.swift
//  SwiftyWalkthrough
//
//  Created by Rui Costa on 29/09/2015.
//  Copyright © 2015 Rui Costa. All rights reserved.
//

import UIKit

extension UIViewController: WalkthroughViewDelegate {

    public var rootController: UIViewController? { return UIApplication.sharedApplication().delegate?.window??.rootViewController }
    
    public var walkthroughView: WalkthroughView? { return attachToWalkthrough() }
    
    public var ongoingWalkthrough: Bool { return walkthroughView != .None }
    
    public func makeWalkthroughView() -> WalkthroughView {
        let v = WalkthroughView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }
    
    public func startWalkthrough(walkthroughView: WalkthroughView) {
        if ongoingWalkthrough {
            finishWalkthrough()
        }
        
        walkthroughView.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["walkthroughView": walkthroughView]
        
        rootController?.view.addSubview(walkthroughView)
        rootController?.view.bringSubviewToFront(walkthroughView)
        
        rootController?.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[walkthroughView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        rootController?.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[walkthroughView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        rootController?.view.setNeedsLayout()
    }
    
    public func attachToWalkthrough() -> WalkthroughView? {
        if let rootSubviews = rootController?.view.subviews {
            for rootSubview in rootSubviews {
                if let walkthrough = rootSubview as? WalkthroughView {
                    walkthrough.delegate = self
                    return walkthrough
                }
            }
        }
        return .None
    }
    
    public func finishWalkthrough() {
        walkthroughView?.removeFromSuperview()
    }
    
}
