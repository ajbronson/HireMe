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
    let storyboard = UIStoryboard(name: "ProviderStoryboard", bundle: Bundle.main)
    var isProviderTabsVisible: Bool = false

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
        UINavigationBar.appearance().barTintColor = defaultColor
        
        // Initialize Facebook sign-in
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Initialize Google sign-in
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        GIDSignIn.sharedInstance().delegate = self
        
        print("Google hasAuthInKeychain: \(GIDSignIn.sharedInstance().hasAuthInKeychain())") // DEBUG
        
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            // Signed in with Google
            print("Already signed in with Google") // DEBUG
            GIDSignIn.sharedInstance().signInSilently()
            self.showProviderTabBarController()
        } else if FBSDKAccessToken.current() != nil {
            // Signed in with Facebook
            print("Already signed in with Facebook") // DEBUG
            self.showProviderTabBarController()
        }
        
		return true
	}
    
    // Needed for Facebook and Google sign-in
    // This is how the sign in knows to come back to the app after a successful sign in
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let fbHandled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        let googleHandled = GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])

        return fbHandled || googleHandled
    }
    
    
    // MARK: GIDSignInDelegate callbacks
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil {
            print("Signed in with Google") // DEBUG
//            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            print("Google token: \(idToken)")

            let googleUserProfile = [
                "fullName": user.profile.name,
                "givenName": user.profile.givenName,
                "familyName": user.profile.familyName,
                "email": user.profile.email
            ]
            
            UserDefaults.standard.set(googleUserProfile, forKey: "googleUserProfile")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationKey), object: nil)
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    
    // MARK: Custom functions
    
    func showProviderTabBarController() {
        if let rootVC = self.window?.rootViewController as? UINavigationController {
            let providerTabBarController = self.storyboard.instantiateViewController(withIdentifier: "ProviderTabBarController") as! ProviderTabBarController
            rootVC.pushViewController(providerTabBarController, animated: false)
            self.isProviderTabsVisible = true
        }
    }
    
    func getCurrentViewController() -> UIViewController? {
        guard var currentVC = self.window?.rootViewController else {
            return nil
        }
        
        while let presentedVC = currentVC.presentedViewController {
            currentVC = presentedVC
        }
        
        return currentVC
    }
}

