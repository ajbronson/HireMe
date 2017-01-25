//
//  FBUserProfileController.swift
//  HireMe
//
//  Created by Nathan Johnson on 1/24/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import FBSDKCoreKit

class FBUserProfileController: NSObject {
    
    func fbGraphRequest(completionHandler handler: FBSDKGraphRequestHandler!) {
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, picture.type(large), email"]).start { (connection, result, error) in
            handler(connection, result, error)
        }
    }
}
