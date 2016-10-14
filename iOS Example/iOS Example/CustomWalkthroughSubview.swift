//
//  CustomWalkthroughSubview.swift
//  iOS Example
//
//  Created by Rui Costa on 30/09/2015.
//  Copyright © 2015 Rui Costa. All rights reserved.
//

import UIKit
import SwiftyWalkthrough

class CustomWalkthroughView: WalkthroughView {
    
    lazy var helpLabel: UILabel = self.makeHelpLabel()
    
    init() {
        super.init(frame: CGRect.zero)
        
        addSubview(helpLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addSubview(helpLabel)
    }
    
    func makeHelpLabel() -> UILabel {
        let l = UILabel()
        l.backgroundColor = UIColor.red
        l.textColor = UIColor.white
        l.textAlignment = .center
        l.numberOfLines = 0
        
        return l
    }
}
