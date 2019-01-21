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
    let extraPaddingX: CGFloat
    let extraPaddingY: CGFloat
    let cornerRadius: CGFloat
    
    public init(view: UIView, extraPaddingX: CGFloat, extraPaddingY: CGFloat, cornerRadius: CGFloat) {
        self.view = view
        self.extraPaddingX = extraPaddingX
        self.extraPaddingY = extraPaddingY
        self.cornerRadius = cornerRadius
    }
    
    public convenience init(view: UIView) {
        self.init(view: view, extraPaddingX: 0, extraPaddingY: 0, cornerRadius: 0)
    }
    
    public convenience init(view: UIView, cornerRadius: CGFloat) {
        self.init(view: view, extraPaddingX: 0, extraPaddingY: 0, cornerRadius: cornerRadius)
    }
}
