//
//  DarkBackgroundButton.swift
//  HireMe
//
//  Created by Nathan Johnson on 2/8/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class DarkHighlightButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? highlightedBackgroundColor : defaultColor
        }
    }
}
