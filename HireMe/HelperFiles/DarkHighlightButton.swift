//
//  DarkBackgroundButton.swift
//  HireMe
//
//  Created by Nathan Johnson on 2/8/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

/// Shows a slightly darker background color when the button is highlighted
class DarkHighlightButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? highlightedBackgroundColor : defaultColor
        }
    }
}
