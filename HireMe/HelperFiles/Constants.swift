//
//  Constants.swift
//  HireMe
//
//  Created by AJ Bronson on 2/7/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

let gSignInNotificationName = Notification.Name(rawValue: "didSignInWithGoogle")
let signOutNotificationName = Notification.Name(rawValue: "didSignOut")

enum BidStatus: String {
	case Selected = "greenIndicator"
	case Rejected = "redIndicator"
	case PendingResponse = "grayIndicator"
	case Cancelled = "cancelIndicator"
}

enum JobStatus: String {
	case open = "Accepting Bids"
	case cancelled = "Cancelled"
	case completed = "Completed"
	case awarded = "Awarded"
}

struct AppColors {
	static let blueColor = UIColor(colorLiteralRed: 0/255.0, green: 188/255.0, blue: 212/255.0, alpha: 1.0)
	static let lightBlueColor = UIColor(colorLiteralRed: 0/255.0, green: 188/255.0, blue: 212/255.0, alpha: 0.6)
	static let greenColor = UIColor(colorLiteralRed: 63/255.0, green: 178/255.0, blue: 86/255.0, alpha: 1.0)
	static let yellowColor = UIColor(colorLiteralRed: 219/255.0, green: 199/255.0, blue: 27/255.0, alpha: 1.0)
}

struct AppInfo {
	static let industries = ["Automotive",
		"House Cleaning",
		"Remodeling/Home Repairs",
		"Technical Support",
		"Yard Maintenance"]
	
	static let states = [	"AL",
	                     	"AK",
	                     	"AZ",
	                     	"AR",
	                     	"CA",
	                     	"CO",
	                     	"CT",
	                     	"DE",
	                     	"FL",
	                     	"GA",
	                     	"HI",
	                     	"ID",
	                     	"IL",
	                     	"IN",
	                     	"IA",
	                     	"KS",
	                     	"KY",
	                     	"LA",
	                     	"ME",
	                     	"MD",
	                     	"MA",
	                     	"MI",
	                     	"MN",
	                     	"MS",
	                     	"MO",
	                     	"MT",
	                     	"NE",
	                     	"NV",
	                     	"NH",
	                     	"NJ",
	                     	"NM",
	                     	"NY",
	                     	"NC",
	                     	"ND",
	                     	"OH",
	                     	"OK",
	                     	"OR",
	                     	"PA",
	                     	"RI",
	                     	"SC",
	                     	"SD",
	                     	"TN",
	                     	"TX",
	                     	"UT",
	                     	"VT",
	                     	"VA",
	                     	"WA",
	                     	"WV",
	                     	"WI",
	                     	"WY"]

}

