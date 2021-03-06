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
class Projects: Decodable {
    let marker_IDs: [Int]
    let tag: String
    let title: String
    let logo: String
    let members: String
    let description: String
    let image: String
    
	
    init(marker_IDs : [Int], tag : String, title : String, logo : String, members : String, description : String, image: String) {
        self.marker_IDs = marker_IDs
        self.title = title
        self.description = description
        self.members = members
        self.logo = logo
        self.image = image
        self.tag = tag
    }
}

