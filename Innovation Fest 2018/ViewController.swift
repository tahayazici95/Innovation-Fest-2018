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
    static var users = [Users]()
    
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
        
        downloadJSONFile { }
    }
    
    // Sign in that checks if the credentials exist
    @IBAction func signin_check(_ sender: UIButton) {
        
        let  results = checkIf(username: usernameTextField.text!, password: passwordTextField.text!, existedIn: ViewController.users)
        if results == true{
            let next = self.storyboard?.instantiateViewController(withIdentifier: "navScreenVC") as! navScreenVC
            let navigation_object = UINavigationController(rootViewController: next)
            self.present(navigation_object, animated: true, completion: nil)
            print("user exsist")
            
        }else if (usernameTextField.text! == "" || passwordTextField.text! == ""){
            
            let alert = UIAlertController(title: "", message: "\nPlease enter your Username and Password", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: {(action) -> Void in })
            
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
            //print("sdnjshdjf")
            
        }else {
            
            let alert = UIAlertController(title: "Login Error", message: "\nUsername or Password is inncorect. Please Re-enter.", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: {(action) -> Void in })
            
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
        
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

    /// Function to download JSON file containing users and projects
    func downloadJSONFile(completed: @escaping () -> ()) {
        
        let url = URL(string: "https://next.json-generator.com/api/json/get/EklYDwNNN")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil {
                do {
                    ViewController.users = try JSONDecoder().decode([Users].self, from: data!)
                    print("downloaded")
                    DispatchQueue.main.async { completed() }
                } catch {
                    print("JSON Error")
                }
            }
        }.resume()
    }
}

