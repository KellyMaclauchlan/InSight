//
//  RoundedRectangleButton.swift
//  In Sight
//
//  Created by Kelly Maclauchlan on 2017-09-09.
//  Copyright © 2017 Kelly Maclauchlan. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable class RoundedRectangleButton: UIButton
{
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
    }
    
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
    }
}
