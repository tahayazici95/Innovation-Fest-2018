//
//  CheckIfUserExists.swift
//  Innovation Fest 2018
//
//  Created by Taha Mahmut Yazici on 04/01/2018.
//  Copyright © 2018 TH Productions. All rights reserved.
//

import Foundation

// Function to check if a Jury with given credentials exists
func checkIf(username: String, password: String, existedIn users: [Users]) -> Bool {
    for user in users {
        if user.username == username && user.password == password { return true }
    }
    
    return false
}
