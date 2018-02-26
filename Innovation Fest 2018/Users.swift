//
//  Users.swift
//  Innovation Fest 2018
//
//  Created by Taha Mahmut Yazici on 04/01/2018.
//  Copyright © 2018 TH Productions. All rights reserved.
//

import Foundation
import UIKit

// Class storing all relevant information about each Jury
class Users: Decodable {
    let username: String
    let password: String
    let tag: String
    let title: String
    let logo: String
    let members: String
    let description: String
    let image: String
    
	
    init(username : String, password : String, tag : String, title : String, logo : String, members : String, description : String, image: String) {
        self.username = username
        self.password = password
        self.title = title
        self.description = description
        self.members = members
        self.logo = logo
        self.image = image
        self.tag = tag
    }
}

