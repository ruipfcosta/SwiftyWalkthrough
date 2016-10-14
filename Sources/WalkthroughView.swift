//
//  WalkthroughView.swift
//  SwiftyWalkthrough
//
//  Created by Rui Costa on 28/09/2015.
//  Copyright © 2015 Rui Costa. All rights reserved.
//

import Foundation

private let defaultDimColor = UIColor.black.withAlphaComponent(0.7).cgColor

@objc public protocol WalkthroughViewDelegate {
    @objc optional func willInteractWithView(_ view: UIView)
}

@objc open class WalkthroughView: UIView {
    
    open var availableViews: [ViewDescriptor] = []
    
    open var dimColor: CGColor = defaultDimColor {
        didSet {
            setNeedsDisplay()
        }
    }
    
    open weak var delegate: WalkthroughViewDelegate?
    
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
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        superview?.bringSubview(toFront: self)
        
        removeOverlaySublayers()
        
        let overlayPath = UIBezierPath(rect: bounds)
        overlayPath.usesEvenOddFillRule = true
        
        for descriptor in availableViews {
            let currentView = descriptor.view
            let convertedFrame = descriptor.view.superview?.convert(currentView.frame, to: overlayView)
            
            if let cf = convertedFrame {
                let highlightedFrame = cf.insetBy(dx: -descriptor.extraPaddingX, dy: -descriptor.extraPaddingY)
                let transparentPath =  UIBezierPath(roundedRect: highlightedFrame, cornerRadius: descriptor.cornerRadius)
                overlayPath.append(transparentPath)
            }
        }
        
        let fillLayer = CAShapeLayer()
        fillLayer.path = overlayPath.cgPath
        fillLayer.fillRule = kCAFillRuleEvenOdd
        fillLayer.fillColor = dimColor
        
        overlayView.layer.addSublayer(fillLayer)
    }
    
    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        for descriptor in availableViews {
            let currentView = descriptor.view
            let convertedPoint = currentView.convert(point, from: self)
            
            if currentView.point(inside: convertedPoint, with: event) {
                delegate?.willInteractWithView?(currentView)
                return currentView.hitTest(convertedPoint, with: event)
            }
        }
        
        return super.hitTest(point, with: event)
    }
    
    func setup() {
        setupSubviews()
        setupConstraints()
        
        isOpaque = false
        
        registerForOrientationChanges()
    }
    
    func setupSubviews() {
        addSubview(overlayView)
    }
    
    func setupConstraints() {
        let views = ["overlayView": overlayView]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[overlayView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[overlayView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }
    
    func makeOverlay() -> UIView {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        
        return v
    }
    
    func registerForOrientationChanges() {
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(WalkthroughView.orientationChanged), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    func unregisterFromOrientationChanges() {
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    func orientationChanged() {
        setNeedsDisplay()
    }
    
    func removeOverlaySublayers() {
        guard let overlaySublayers = overlayView.layer.sublayers else { return }
        
        overlaySublayers.forEach { $0.removeFromSuperlayer() }
    }
    
    open func cutHolesForViews(_ views: [UIView]) {
        let descriptors = views.map(ViewDescriptor.init)
        cutHolesForViewDescriptors(descriptors)
    }
    
    open func cutHolesForViewDescriptors(_ views: [ViewDescriptor]) {
        availableViews = views
        setNeedsDisplay()
    }
    
    open func removeAllHoles() {
        cutHolesForViewDescriptors([])
    }
    
}
