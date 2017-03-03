//
//  DarkBackgroundButton.swift
//  HireMe
//
//  Created by Nathan Johnson on 2/8/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

let defaultColor = UIColor(hex: "#00BCD4") // Cyan primary
let highlightedBackgroundColor = UIColor(hex: "#0097A7") // Cyan 700

/// Shows a slightly darker background color when the button is highlighted
class DarkHighlightButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? highlightedBackgroundColor : defaultColor
        }
    }
}
