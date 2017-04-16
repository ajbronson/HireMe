//
//  Extensions.swift
//  HireMe
//
//  Created by AJ Bronson on 1/30/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

extension Data {
    func toJSON() -> Any? {
        return try? JSONSerialization.jsonObject(with: self, options: [])
    }
    
    func toDictionary() -> [String: Any]? {
        return self.toJSON() as? [String: Any]
    }
}

extension Double {
    func convertToCurrency(includeDollarSign: Bool = true, truncateZeros: Bool = true) -> String? {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
        
        if truncateZeros {
            formatter.maximumFractionDigits = 2
        }
        
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
    
    func toDouble(from numberStyle: NumberFormatter.Style) -> Double? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = numberStyle
        
        guard let number = numberFormatter.number(from: self) else { return nil }
        
        return number.doubleValue
    }
}

extension URLRequest {
    mutating func addContentTypeHeader(mimeType: NetworkConroller.MIMEType) {
        self.addValue(mimeType.rawValue, forHTTPHeaderField: "Content-Type")
    }
}


// MARK: - UIKit extensions

extension UIApplication {
    class func visibleViewController(from viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return visibleViewController(from: nav.visibleViewController)
        }
        
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return visibleViewController(from: selected)
            }
        }
        
        if let presented = viewController?.presentedViewController {
            return visibleViewController(from: presented)
        }
        
        return viewController
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

extension NextPrevControlTextField {
    /// Adds a toolbar on top of the keyboard when user is editing. Toolbar contains a close button to dismiss the keyboard and up and down buttons to "tab" between text fields
    func addToolbarAboveKeyboard() {
        let keyboardToolbar = UIToolbar()

        let close = ClosureBarButtonItem(image: UIImage(named: "Close"), style: .plain) {(
            self.resignFirstResponder()
        )}
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let up = ClosureBarButtonItem(image: UIImage(named: "UpChevron"), style: .plain) {(
            self.transferFirstResponderToPrevControl(completionHandler: nil)
        )}
        up.isEnabled = self.prevControl == nil ? false : true
        
        let down = ClosureBarButtonItem(image: UIImage(named: "DownChevron"), style: .plain) {(
            self.transferFirstResponderToNextControl(completionHandler: nil)
        )}
        down.isEnabled = self.nextControl == nil ? false : true
        
        keyboardToolbar.items = [close, flexSpace, up, down]
        keyboardToolbar.sizeToFit()
        
        self.inputAccessoryView = keyboardToolbar
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

// MARK: - For debugging

extension UIViewController {
    var className: String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
    
    /// Prints the class name and storyboard ID
    var descr: String {
        return "class: \(self.className), ID: \(String(describing: self.restorationIdentifier)), storyboard: \(String(describing: self.storyboardName))"
    }
    
    var storyboardName: String? {
        return self.storyboard?.value(forKey: "name") as? String
    }
}

extension UINavigationController {
    func printViewControllers() {
        var i = 0
        
        for vc in self.viewControllers {
            print("viewControllers[\(i)] \(vc.descr)")
            i += 1
        }
    }
}

extension UserDefaults {
    func printKeys() {
        print("UserDefaults Keys\n-----------------")
        var i = 0
        
        for key in self.dictionaryRepresentation().keys {
            i += 1
            print("\(i): \(key)")
        }
    }
}


