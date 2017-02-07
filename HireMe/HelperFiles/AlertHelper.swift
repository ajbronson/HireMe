//
//  AlertHelper.swift
//  HireMe
//
//  Created by AJ Bronson on 1/30/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class AlertHelper {

	static func showAlert(view: UIViewController, title: String?, message: String?, closeButtonText: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let closeAction = UIAlertAction(title: closeButtonText, style: .default, handler: nil)
		alert.addAction(closeAction)
		view.present(alert, animated: true, completion: nil)
	}
}
