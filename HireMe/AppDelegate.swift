//
//  AppDelegate.swift
//  HireMe
//
//  Created by AJ Bronson on 11/3/16.
//  Copyright © 2016 AJ Bronson. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Google
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
        UINavigationBar.appearance().barTintColor = UIColor(red:0.00, green:0.74, blue:0.83, alpha:1.0) // #00BCD4
        
        // Initialize Facebook sign-in
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Initialize Google sign-in
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        GIDSignIn.sharedInstance().delegate = self
        
        // Go straight to the tab bar controller if the user is logged in
        if FBSDKAccessToken.current() != nil || GIDSignIn.sharedInstance().currentUser != nil {
            // User is logged in, show the tabs view controller
            let storyboard = UIStoryboard(name: "Provider", bundle: Bundle.main)
            self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "providerTabsNavController")
        }
        
		return true
	}
    
    // Needed for Facebook and Google login
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let fbHandled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        let googleHandled = GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return fbHandled || googleHandled
    }
    
    
    // MARK: GIDSignInDelegate callbacks
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil {
//            let userId = user.userID                  // For client-side use only!
//            let idToken = user.authentication.idToken // Safe to send to the server

            let googleUserProfile = [
                "fullName": user.profile.name,
                "givenName": user.profile.givenName,
                "familyName": user.profile.familyName,
                "email": user.profile.email
            ]
            
            UserDefaults.standard.set(googleUserProfile, forKey: "googleUserProfile")
            let storyboard = UIStoryboard(name: "Provider", bundle: Bundle.main)
            self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "providerTabsNavController")
        } else {
            print("\(error.localizedDescription)")
        }
    }
}

