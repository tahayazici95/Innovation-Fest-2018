//
//  ViewController.swift
//  Innovation Fest 2018
//
//  Created by Taha Mahmut Yazici on 04/01/2018.
//  Copyright © 2018 TH Productions. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    // Declaring objects that will be interacted with
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    // Declaring the Users array that will store all users received from the JSON file for authentification
    static var allProjects = [Projects]()
    static var projects = [Projects]()
    static var juries = [Juries]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Request permission to display notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if error != nil {
                print("Authorization Unsuccesful")
            } else {
                print("Authorization Succesful")
            }
        }
        
        // Display notification
        timeNotification(inSecodes: 5) { (success) in
            if success {
                print("Succesfully Notified")
            }
        }
        
        // Download Juries Database from online JSON
        downloadJSONFile(type: "juries") { }
    }
    
    
    // Sign in that checks if the credentials exist
    @IBAction func signin_check(_ sender: UIButton) {

        let (juryID, check) = checkIf(username: usernameTextField.text!, password: passwordTextField.text!, existedIn: ViewController.juries)
        
        if check {
            // If the user exists -> Download Projects Database from online JSON
            downloadJSONFile(type: String(juryID)) { }
            
            // Navigate to next screen
            let next = self.storyboard?.instantiateViewController(withIdentifier: "navScreenVC") as! navScreenVC
            let navigation_object = UINavigationController(rootViewController: next)
            self.present(navigation_object, animated: true, completion: nil)
            print("User Exists!")
            
        }else if (usernameTextField.text! == "" || passwordTextField.text! == ""){
            
            // Display Error message as input field was left empty
            let alert = UIAlertController(title: "", message: "\nPlease enter your Username and Password", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: {(action) -> Void in })
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
            
        }else {
            
            // Display Error message as inputs are incorrect
            let alert = UIAlertController(title: "Login Error", message: "\nUsername or Password is inncorect. Please Re-enter.", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: {(action) -> Void in })
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

