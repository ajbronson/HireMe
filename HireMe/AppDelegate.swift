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
    let storyboard = UIStoryboard(name: "Provider", bundle: Bundle.main)
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        return true
    }

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
        UINavigationBar.appearance().barTintColor = UIColor(red:0.00, green:0.74, blue:0.83, alpha:1.0) // #00BCD4
        
        // Initialize Facebook sign-in
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Initialize Google sign-in
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        GIDSignIn.sharedInstance().delegate = self
        
        print("Google hasAuthInKeychain: \(GIDSignIn.sharedInstance().hasAuthInKeychain())")
        
        if SignInMethod.NotSignedIn.rawValue != getSignInMethod().rawValue {
            print("Already signed in")
            self.showProviderTabBarController()
        }
        
		return true
	}
    
    // Needed for Facebook and Google sign-in
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let fbHandled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        let googleHandled = GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return fbHandled || googleHandled
    }
    
    
    // MARK: GIDSignInDelegate callbacks
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil {
            print("Signed in with Google")
//            let userId = user.userID                  // For client-side use only!
//            let idToken = user.authentication.idToken // Safe to send to the server

            let googleUserProfile = [
                "fullName": user.profile.name,
                "givenName": user.profile.givenName,
                "familyName": user.profile.familyName,
                "email": user.profile.email
            ]
            
            UserDefaults.standard.set(googleUserProfile, forKey: "googleUserProfile")
            setSignInMethod(as: SignInMethod.Google)
            self.showProviderTabBarController()
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    
    // MARK: Custom functions
    
    func showProviderTabBarController() {
        self.window?.rootViewController = self.storyboard.instantiateViewController(withIdentifier: "providerTabsNavController")
    }
}

