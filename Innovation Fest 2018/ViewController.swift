//
//  ViewController.swift
//  Innovation Fest 2018
//
//  Created by Taha Mahmut Yazici on 04/01/2018.
//  Copyright © 2018 TH Productions. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, NSURLConnectionDelegate {

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
        
        //urlpull()

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
    
    func urlpull()
    {
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
        

        //let urlConnection = NSURLConnection(request: request, delegate: self)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(data)
            print(response)
            if error == nil {
                do {
                    ViewController.juries = try JSONDecoder().decode([Juries].self, from: data!)
                    print("Juries downloadedv- new stuff")
                    
                } catch {
                    print("JSON Error - new stuff")
                }
            }
            }.resume()
        
    }
}

