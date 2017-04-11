//
//  RatingStarsHelper.swift
//  HireMe
//
//  Created by Nathan Johnson on 3/18/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class RatingStarsHelper {
    
    /**
     Displays the specified number of star images out of the list of image views.
     
     The assumption is that the image views are all very close to each other sequentially, either horiztonally or vertically, like in a stack view.
     
     - Parameter numberOfStars: The number of filled-in stars to show
     - Parameter stars: The image views that will be showing either a filled-in star or a blank star
     
     - Attention: The order of the image views for `stars` matters. Make sure to pass in the image views in the order you want the stars to display in.
     */
    static func show(_ numberOfStars: Int, stars: [UIImageView?]) {
        for i in 0..<stars.count {
            /*
             Example
             numberOfStars = 2, which means the first two stars must be filled in
             2 > 0 (first star), show a star
             2 > 1 (second star), show a star
             2 > 2 (third star), show a blank star
             etc.
             */
            stars[i]?.image = numberOfStars > i ? UIImage(named: "Star") : UIImage(named: "BlankStar")
        }
    }
}
