//
//  ViewDescriptor.swift
//  SwiftyWalkthrough
//
//  Created by Rui Costa on 28/09/2015.
//  Copyright © 2015 Rui Costa. All rights reserved.
//

import Foundation

@objc open class ViewDescriptor: NSObject {
    
    let view: UIView
    let cornerRadius: CGFloat
    let rectEdges: UIEdgeInsets
    
    
    
    public init(view: UIView, rectEdges:UIEdgeInsets, cornerRadius: CGFloat) {
        self.view = view
        self.rectEdges = rectEdges
        self.cornerRadius = cornerRadius
    }
    
    public convenience init(view: UIView) {
        self.init(view: view, rectEdges: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), cornerRadius: 0)
    }
    
    public convenience init(view: UIView, cornerRadius: CGFloat) {
        self.init(view: view, rectEdges: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), cornerRadius: cornerRadius)
    }
    
    public convenience init(view: UIView, extraPaddingX: CGFloat, extraPaddingY: CGFloat, cornerRadius: CGFloat) {
        let rect = UIEdgeInsets(top: -extraPaddingY, left: -extraPaddingX, bottom: -extraPaddingY, right: -extraPaddingX)
        self.init(view: view, rectEdges: rect, cornerRadius: cornerRadius);
    }
    
    public convenience init(view: UIView, extraPaddingLeft: CGFloat, extraPaddingTop: CGFloat, extraPaddingRight: CGFloat, extraPaddingBottom: CGFloat, cornerRadius: CGFloat) {
        let rect = UIEdgeInsets(top: -extraPaddingTop, left: -extraPaddingLeft, bottom: -extraPaddingBottom, right: -extraPaddingRight)
        self.init(view: view, rectEdges: rect, cornerRadius: cornerRadius);
    }
}
