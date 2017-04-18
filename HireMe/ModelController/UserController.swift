//
//  UserController.swift
//  HireMe
//
//  Created by Nathan Johnson on 4/12/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import Foundation

final class UserController {
    static let shared = UserController()
    
    // MARK: - Properties
    
    private var user: User? {
        didSet { user?.cache() }
    }
    
    private init() {}
    
    // MARK: - Methods
    
    func currentUser() -> User? {
        if let currentUser = user {
            return currentUser
        } else {
            guard let userDict = UserDefaults.standard.dictionary(forKey: CURRENT_USER_KEY) else { return nil }
            print("currentUser(): \(userDict)") // DEBUG
            user = try? User(dictionary: userDict)
            
            return user
        }
    }
    
    func setCurrentUser(_ user: User) {
        self.user = user
    }
}
