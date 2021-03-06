//
//  listVC.swift
//  Innovation Fest 2018
//
//  Created by Taha Mahmut Yazici on 14/01/2018.
//  Copyright © 2018 TH Productions. All rights reserved.
//

import UIKit

class listVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    static var selectedUserIndex: Projects?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 100
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.projects.count
    }
    
    
    // Form the table using the projects extracted from the JSON file
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "projectListTVC") as? projectListTVC else { return UITableViewCell() }
        
        cell.title.text = ViewController.projects[indexPath.row].title
        
        cell.image_view.layer.cornerRadius = cell.image_view.frame.size.width/2
        cell.image_view.clipsToBounds = true
        
        cell.title.layer.cornerRadius = cell.title.frame.size.width/2
        
        if let imageURL = URL(string: ViewController.projects[indexPath.row].logo){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data  = data{
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.image_view.image = image
                    }
                }
            }
        }
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    
    @IBAction func sendMarksButton(_ sender: UIBarButtonItem) {
        let saved_data = CoreDataHandler.fetchObject()
        print(saved_data?.count)
        if(saved_data?.count != 5)
        {
            let alert = UIAlertController(title: "",message: "\nPlease Mark all Projects",preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "Back", style: .destructive, handler: { (action) -> Void in })
            
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? listDetailsVC{
            destination.selected_user = ViewController.projects[(tableView.indexPathForSelectedRow?.row)!]
            
            listVC.selectedUserIndex = ViewController.projects[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    
}
