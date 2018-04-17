//
//  Juries.swift
//  Innovation Fest 2018
//
//  Created by Aaisha Rehman on 17/04/2018.
//  Copyright © 2018 TH Productions. All rights reserved.
//

import Foundation

class Juries: Decodable {
    let ID: Int
    let names: String
    let username: String
    let password: String
    
    init(ID : Int, names : String, username : String, password : String) {
        self.ID = ID
        self.names = names
        self.username = username
        self.password = password
    }
}
