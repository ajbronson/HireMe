//
//  DarkBackgroundButton.swift
//  HireMe
//
//  Created by Nathan Johnson on 2/8/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

let highlightedBackgroundColor = UIColor(red:0.00, green:0.59, blue:0.65, alpha:1.0) // Cyan 700 #0097A7
let defaultColor = UIColor(red:0.00, green:0.74, blue:0.83, alpha:1.0) // Cyan primary #00BCD4

class DarkHighlightButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? highlightedBackgroundColor : defaultColor
        }
    }
}
