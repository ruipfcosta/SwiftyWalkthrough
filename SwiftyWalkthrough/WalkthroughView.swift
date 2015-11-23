//
//  WalkthroughView.swift
//  SwiftyWalkthrough
//
//  Created by Rui Costa on 28/09/2015.
//  Copyright © 2015 Rui Costa. All rights reserved.
//

import Foundation

private let defaultDimColor = UIColor.blackColor().colorWithAlphaComponent(0.7).CGColor

@objc public protocol WalkthroughViewDelegate {
    optional func willInteractWithView(view: UIView)
}

@objc public class WalkthroughView: UIView {
    
    public var availableViews: [ViewDescriptor] = []
    
    public var dimColor: CGColor = defaultDimColor {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public weak var delegate: WalkthroughViewDelegate?
    
    lazy var overlayView: UIView = self.makeOverlay()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    deinit {
        unregisterFromOrientationChanges()
    }
    
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        superview?.bringSubviewToFront(self)
        
        removeOverlaySublayers()
        
        let overlayPath = UIBezierPath(rect: bounds)
        overlayPath.usesEvenOddFillRule = true
        
        for descriptor in availableViews {
            let currentView = descriptor.view
            let convertedFrame = descriptor.view.superview?.convertRect(currentView.frame, toView: overlayView)
            
            if let cf = convertedFrame {
                let highlightedFrame = CGRectInset(cf, -descriptor.extraPaddingX, -descriptor.extraPaddingY)
                let transparentPath =  UIBezierPath(roundedRect: highlightedFrame, cornerRadius: descriptor.cornerRadius)
                overlayPath.appendPath(transparentPath)
            }
        }
        
        let fillLayer = CAShapeLayer()
        fillLayer.path = overlayPath.CGPath
        fillLayer.fillRule = kCAFillRuleEvenOdd
        fillLayer.fillColor = dimColor
        
        overlayView.layer.addSublayer(fillLayer)
    }
    
    override public func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        for descriptor in availableViews {
            let currentView = descriptor.view
            let convertedPoint = currentView.convertPoint(point, fromView: self)
            
            if currentView.pointInside(convertedPoint, withEvent: event) {
                delegate?.willInteractWithView?(currentView)
                return currentView.hitTest(convertedPoint, withEvent: event)
            }
        }
        
        return super.hitTest(point, withEvent: event)
    }
    
    func setup() {
        setupSubviews()
        setupConstraints()
        
        opaque = false
        
        registerForOrientationChanges()
    }
    
    func setupSubviews() {
        addSubview(overlayView)
    }
    
    func setupConstraints() {
        let views = ["overlayView": overlayView]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[overlayView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[overlayView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }
    
    func makeOverlay() -> UIView {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        
        return v
    }
    
    func registerForOrientationChanges() {
        UIDevice.currentDevice().beginGeneratingDeviceOrientationNotifications()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "orientationChanged", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    func unregisterFromOrientationChanges() {
        UIDevice.currentDevice().endGeneratingDeviceOrientationNotifications()
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    func orientationChanged() {
        setNeedsDisplay()
    }
    
    func removeOverlaySublayers() {
        if let overlaySublayers = overlayView.layer.sublayers {
            for l in overlaySublayers {
                l.removeFromSuperlayer()
            }
        }
    }
    
    public func cutHolesForViews(views: [UIView]) {
        cutHolesForViewDescriptors(views.map { ViewDescriptor(view: $0) })
    }
    
    public func cutHolesForViewDescriptors(views: [ViewDescriptor]) {
        availableViews = views
        setNeedsDisplay()
    }
    
    public func removeAllHoles() {
        cutHolesForViewDescriptors([])
    }
    
}
