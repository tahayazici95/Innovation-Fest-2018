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
        url = URL(string: "https://next.json-generator.com/api/json/get/4yfqu8DXE")
        
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
        }.resume()
        
    } else {
        
        url = URL(string: "https://next.json-generator.com/api/json/get/EklYDwNNN")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
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
        }.resume()
    }
}


func extractProject(belongingTo juryID: Int) -> [Projects] {
    var newProjects: [Projects] = []
    
    print("Project count:", ViewController.allProjects.count)
    
    for project in ViewController.allProjects {
        
        print("Current project", project)
        
        for markerID in project.marker_IDs {
            
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
