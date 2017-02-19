//
//  Extensions.swift
//  HireMe
//
//  Created by AJ Bronson on 1/30/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

let highlightedBackgroundColor = UIColor(hex: "#0097A7") // Cyan 700
let defaultColor = UIColor(hex: "#00BCD4") // Cyan primary
let hueColor = UIColor(hex: "#E0F7FA") // Cyan 50
let fbBlue = UIColor(hex: "#4267B2")

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
			} else {
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
	func convertToCurrency() -> String? {
		let formatter = NumberFormatter()
		formatter.numberStyle = NumberFormatter.Style.currency
		return formatter.string(from: NSNumber(value: self))
	}
}

extension UIColor {
    convenience init?(hex: String) {
        var rgb: UInt64 = 0
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }
        
        if hexSanitized.characters.count == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
        } else if hexSanitized.characters.count == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}

extension UINavigationBar {
    func transparent() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage() // Sets shadow (line below the bar) to a blank image
    }
    
    func opaque() {
        self.setBackgroundImage(nil, for: .default) // Restore background
        self.shadowImage = nil // Restore shadow (line below the bar)
    }
    
    /// Hides the navigation bar's bottom line
    func hideShadowImage() {
        self.getShadowImageView()?.isHidden = true
    }
    
    /// Shows the navigation bar's bottom line
    func showShadowImage() {
        self.getShadowImageView()?.isHidden = false
    }
    
    /// Gets the navigation bar's bottom line UIImageView
    private func getShadowImageView() -> UIImageView? {
        for parent in self.subviews {
            for childView in parent.subviews {
                if childView is UIImageView {
                    return (childView as! UIImageView)
                }
            }
        }
        
        return nil
    }
}

extension UITableView {
    /// Hides empty cells while still keeping the bottom border of the last non-empty cell
    func hideEmptyCells() {
        self.tableFooterView = UIView()
    }
}

extension UITextField {
    /// Adds a bottom border only to the UITextField.
    func bottomBorder() {
        let border = CALayer()
        let width: CGFloat = 1.0
        
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

extension UIView {
    /// Gets the current first responder (e.g., the UITextField that is being edited and showing the keyboard)
    func currentFirstResponder() -> UIResponder? {
        if self.isFirstResponder {
            return self
        }
        
        for view in self.subviews {
            if let responder = view.currentFirstResponder() {
                return responder
            }
        }
        
        return nil
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
