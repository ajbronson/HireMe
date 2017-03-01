//
//  LocationHelper.swift
//  HireMe
//
//  Created by AJ Bronson on 2/10/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit
import CoreLocation

class LocationHelper {

	static let shared = LocationHelper()

	var locationManager: CLLocationManager?

	init() {
		locationManager = CLLocationManager()
		locationManager?.requestWhenInUseAuthorization()
	}

	func getCurrentLocation(completionHandler: ((_ city: String?, _ state: String?, _ zip: String?) -> Void)?) -> Bool {
		let locationManager = CLLocationManager()
		if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
			if let location = locationManager.location {
				CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
					if error != nil {
						print("Location Retrieval Failed")
						if let completionHandler = completionHandler {
							completionHandler(nil, nil, nil)
						}
					}

					if let placemarks = placemarks,
						placemarks.count > 0 {
						let pm = placemarks[0]
						if let city = pm.locality,
							let state = pm.administrativeArea,
							let zip = pm.postalCode,
							let completionHandler = completionHandler {
							completionHandler(city, state, zip)
						}
					} else if let completionHandler = completionHandler {
						completionHandler(nil, nil, nil)
					}
				})
				return true
			}
		}
		return false
	}
}
