//
//  ClosureBarButtonItem.swift
//  HireMe
//
//  Created by Nathan Johnson on 2/26/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

/// Allows closures to be passed as arguments instead of `Selector`s for `init` functions
class ClosureBarButtonItem: UIBarButtonItem {
    private var actionHandler: ((Void) -> Void)?
    
    convenience init(title: String?, style: UIBarButtonItemStyle, actionHandler: (() -> Void)?) {
        self.init(title: title, style: style, target: nil, action: #selector(barButtonItemPressed))
        self.target = self
        self.actionHandler = actionHandler
    }
    
    convenience init(image: UIImage?, style: UIBarButtonItemStyle, actionHandler: (() -> Void)?) {
        self.init(image: image, style: style, target: nil, action: #selector(barButtonItemPressed))
        self.target = self
        self.actionHandler = actionHandler
    }
    
    func barButtonItemPressed(sender: UIBarButtonItem) {
        self.actionHandler?()
    }
}
