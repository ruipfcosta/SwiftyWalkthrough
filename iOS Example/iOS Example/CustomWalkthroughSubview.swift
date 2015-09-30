//
//  CustomWalkthroughSubview.swift
//  iOS Example
//
//  Created by Rui Costa on 30/09/2015.
//  Copyright © 2015 Rui Costa. All rights reserved.
//

import UIKit

class CustomWalkthroughSubview: UIView {
    
    lazy var helpLabel: UILabel = self.makeHelpLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        addSubview(helpLabel)
    }
    
    func makeHelpLabel() -> UILabel {
        let l = UILabel()
        l.backgroundColor = UIColor.redColor()
        l.textColor = UIColor.whiteColor()
        l.textAlignment = .Center
        l.numberOfLines = 0
        
        return l
    }
}