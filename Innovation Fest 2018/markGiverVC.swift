//
//  markGiverVC.swift
//  Innovation Fest 2018
//
//  Created by Taha Mahmut Yazici on 15/01/2018.
//  Copyright © 2018 TH Productions. All rights reserved.
//

import UIKit

class markGiverVC: UIViewController {

    @IBOutlet weak var textLabel1: UILabel!
    @IBOutlet weak var textLabel2: UILabel!
    @IBOutlet weak var textLabel3: UILabel!
    @IBOutlet weak var textLabel4: UILabel!
    
    @IBOutlet weak var textBox1: UITextField!
    @IBOutlet weak var textBox2: UITextField!
    @IBOutlet weak var textBox3: UITextField!
    @IBOutlet weak var textBox4: UITextField!

    var saved_data = CoreDataHandler.fetchObject()
    
    @IBAction func submissionButton(_ sender: UIButton) {
        
        
        if let i = saved_data?.index(where: { $0.title == listDetailsVC.project_title }) {
            CoreDataHandler.deleteObject(saved_p: saved_data![i])
            
            print("Deleted")
        }
        
        // Save the marks given
        CoreDataHandler.saveObject(title: listDetailsVC.project_title,
                                   innovation: textBox2.text!,
                                   teamwork: textBox4.text!,
                                   enterp: textBox3.text!,
                                   inspiration: textBox1.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel1.text = "Inspiration"
        textLabel2.text = "Innovation"
        textLabel3.text = "Entrepreneurship"
        textLabel4.text = "Teamwork"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
