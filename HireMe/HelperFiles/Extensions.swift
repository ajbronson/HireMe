//
//  Extensions.swift
//  HireMe
//
//  Created by AJ Bronson on 1/30/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

extension UIImageView
{
	func roundCornersForAspectFit(radius: CGFloat)
	{
		if let image = self.image {

			//calculate drawingRect
			let boundsScale = self.bounds.size.width / self.bounds.size.height
			let imageScale = image.size.width / image.size.height

			var drawingRect : CGRect = self.bounds

			if boundsScale > imageScale {
				drawingRect.size.width =  drawingRect.size.height * imageScale
				drawingRect.origin.x = (self.bounds.size.width - drawingRect.size.width) / 2
			}else{
				drawingRect.size.height = drawingRect.size.width / imageScale
				drawingRect.origin.y = (self.bounds.size.height - drawingRect.size.height) / 2
			}
			let path = UIBezierPath(roundedRect: drawingRect, cornerRadius: radius)
			let mask = CAShapeLayer()
			mask.path = path.cgPath
			self.layer.mask = mask
		}
	}
}

extension Double {
	func convertToCurrency(includeDollarSign: Bool) -> String? {
		let formatter = NumberFormatter()
		formatter.numberStyle = NumberFormatter.Style.currency
		let money = formatter.string(from: NSNumber(value: self))
		if let money = money, !includeDollarSign && money.characters.count > 0 {
			return money.substring(from: money.index(money.startIndex, offsetBy: 1))
		} else {
			return money
		}
	}
}

extension Date {
	func stringFromDate() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM dd, yyyy"
		return dateFormatter.string(from: self)
	}
}

extension String {
	func dateFromString() -> Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM dd, yyyy"
		let date = dateFormatter.date(from: self)
		return date
	}
}

// For debugging
extension UIViewController {
    var className: String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
    
    var descr: String {
        return "class: \(self.className), ID: \(self.restorationIdentifier)"
    }
}

// For debugging
extension UINavigationController {
    func printViewControllers() {
        var i = 0
        
        for vc in self.viewControllers {
            print("viewControllers[\(i)] \(vc.descr)")
            i += 1
        }
    }
}

