//
//  CheckIfUserExists.swift
//  Innovation Fest 2018
//
//  Created by Taha Mahmut Yazici on 04/01/2018.
//  Copyright © 2018 TH Productions. All rights reserved.
//

import Foundation
import UserNotifications


// Function to check if a Jury with given credentials exists
func checkIf(username: String, password: String, existedIn juries: [Juries]) -> (Int, Bool) {
    for jury in juries {
        if jury.username == username && jury.password == password { return (jury.ID, true) }
    }
    
    return (0, false)
}


/// Function to download JSON file containing users and projects
func downloadJSONFile(type: String, completed: @escaping () -> ()) {
    
    var url: URL?
    
    if type == "juries" {
        
        let username = "application"
        let password = "^OaYEHBGrB7Bpidxgyx1VWph9AD3sTjS"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        // create the request
        let url = URL(string: "https://innovationfest.co.uk/users")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
       
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                do {
                    ViewController.juries = try JSONDecoder().decode([Juries].self, from: data!)
                    print("Juries downloadedv- new stuff")
                    DispatchQueue.main.async { completed() }
                    
                } catch {
                    print("JSON Error - new stuff")
                }
            }
        }.resume()
        /*url = URL(string: "https://next.json-generator.com/api/json/get/4yfqu8DXE")
        
        
        
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    ViewController.juries = try JSONDecoder().decode([Juries].self, from: data!)
                    print("Juries downloaded")
                    DispatchQueue.main.async { completed() }
                } catch {
                    print("JSON Error")
                }
            }
        }.resume() */
        
    } else {
        
        let username = "application"
        let password = "^OaYEHBGrB7Bpidxgyx1VWph9AD3sTjS"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        // create the request
        let url = URL(string: "https://innovationfest.co.uk/productinfo")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(data)
            print(response)
            if error == nil {
                do {
                    ViewController.allProjects = try JSONDecoder().decode([Projects].self, from: data!)
                    print("Projects downloaded- new stuff")
                    
                    ViewController.projects = extractProject(belongingTo: Int(type)!)
                    DispatchQueue.main.async { completed() }
                    
                } catch {
                    print("Project JSON Error  - new stuff")
                }
            }
        }.resume()
        
        /*url = URL(string: "https://next.json-generator.com/api/json/get/EklYDwNNN")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            print(data)
            print(response)
            if error == nil {
                do {
                    ViewController.allProjects = try JSONDecoder().decode([Projects].self, from: data!)
                    print("Projects downloaded")
                    
                    ViewController.projects = extractProject(belongingTo: Int(type)!)
                    
                    DispatchQueue.main.async { completed() }
                } catch {
                    print("JSON Error")
                }
            }
        }.resume()*/
    }
}


func extractProject(belongingTo juryID: Int) -> [Projects] {
    var newProjects: [Projects] = []
    
    print("Project count:", ViewController.allProjects.count)
    
    for project in ViewController.allProjects {
        
        var split_marksID = project.marker_IDs.components(separatedBy: ",")
        split_marksID[0] = split_marksID[0].replacingOccurrences(of: "[", with: "", options: .literal, range: nil)
        split_marksID[1] = split_marksID[1].replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        split_marksID[2] = split_marksID[2].replacingOccurrences(of: "]", with: "", options: .literal, range: nil)
        split_marksID[2] = split_marksID[2].replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        
        var ids = [Int(split_marksID[0])!, Int(split_marksID[1])!, Int(split_marksID[2])!]
        
//
//        ids[0] = Int(split_marksID[0])!
//        ids[1] = Int(split_marksID[1])!
//        ids[2] = Int(split_marksID[2])!
        
        print(ids[0] = Int(split_marksID[0])!)
        print(ids[1] = Int(split_marksID[1])!)
        print(ids[2] = Int(split_marksID[2])!)
        
 
        print("Current project", project)
        
        for markerID in ids {
            
            print("ID comparison", markerID, " ", juryID)
            
            if markerID == juryID {
                newProjects.append(project)
            }
        }
    }
    
    print("No of projects extracted:", newProjects.count)
    
    return newProjects
}


// Function for displaying notification - will be modified for optimum usage in the future
func timeNotification(inSecodes: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSecodes, repeats: false)
    
    let content = UNMutableNotificationContent()
    
    content.title = "Porjects Marking"
    content.subtitle = "Do not forget to mark your projects!"
    content.body = "Innovation Fest 2018 is nearing the ceremony. Make sure you mark all your project by then."
    
    let request = UNNotificationRequest(identifier: "customNotification", content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request) { (error) in
        if error != nil {
            completion(false)
        } else {
            completion(true)
        }
    }
}
