//
//  listDetailsVC.swift
//  Innovation Fest 2018
//
//  Created by Taha Mahmut Yazici on 15/01/2018.
//  Copyright © 2018 TH Productions. All rights reserved.
//

import UIKit

class listDetailsVC: UIViewController {
    
    @IBOutlet weak var projectImage: UIImageView!
    @IBOutlet weak var projectLogo: UIImageView!
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var projectMembers: UILabel!
    @IBOutlet weak var projectDescription: UILabel!
    
    @IBAction func giveMarksButton(_ sender: UIButton) {
        performSegue(withIdentifier: "giveMarks", sender: self)
    }
    
    // If available, display marks given before
    @IBAction func displayMarksButton(_ sender: UIButton) {
        let saved_data =   CoreDataHandler.fetchObject()
        
        // Iterate through the marks to get the desired one
        var isFound = false
        for i in saved_data!{
            print(i.title!)
            
            if i.title == self.projectTitle.text{
                DispatchQueue.main.async {
                        // Display as pop-up text the given marks from before
                        let alert = UIAlertController(title: "Marks",
                                                      message: "\n\(i.title!)\nInspiration: \(i.inspiration!)" +
                                                               "\nInnovation: \(i.innovation!):" +
                                                               "\nEntrepreneurship: \(i.enterp!)" +
                                                               "\nTeamwork: \(i.teamwork!)",
                                                      preferredStyle: .alert)
                        
                        let cancel = UIAlertAction(title: "Back", style: .destructive, handler: { (action) -> Void in })
                        
                        alert.addAction(cancel)
                        self.present(alert, animated: true, completion: nil)
                }
                
                isFound = true
            }
        }
        
        if isFound != true {
            let alert = UIAlertController(title: "",message: "\nThis project is not yet marked.",preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "Back", style: .destructive, handler: { (action) -> Void in })
            
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
        
    
    var selected_user : Users?
    
    static var project_title: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var membersString: String = ""
        let membersArray = selected_user?.members.components(separatedBy: ", ")
        for member in membersArray! {
            membersString = membersString + member + "\n"
        }
        
        projectTitle.text = selected_user?.title
        listDetailsVC.project_title = (selected_user?.title)!
        
        projectMembers.text = membersString
        
        projectDescription.text = selected_user?.description
        
        if let imageURL = URL(string: (selected_user?.image)!){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data  = data{
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.projectImage.image = image
                    }
                }
            }
        }
        
        if let logoURL = URL(string: (selected_user?.logo)!){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: logoURL)
                if let data  = data{
                    let logo = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.projectLogo.image = logo
                    }
                }
            }
        }
    }
}
