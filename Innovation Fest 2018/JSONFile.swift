//
//  JSONFile.swift
//  Innovation Fest 2018
//
//  Created by Taha Mahmut Yazici on 04/01/2018.
//  Copyright © 2018 TH Productions. All rights reserved.
//

import Foundation

func downloadJOSNFile(completed: @escaping () -> ()) -> [User] {
    var users = [User]()
    let url = URL(string: "https://next.json-generator.com/api/json/get/4JyVJjPG4")
    
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
        
        if error == nil {
            do {
                users = try JSONDecoder().decode([User].self, from: data!)
                print("downloaded")
                DispatchQueue.main.async {
                    completed()
                }
            } catch {
                print("JSON Error")
            }
        }
    }.resume()
    
    return users
}
