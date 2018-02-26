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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 100
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.users.count
    }
    
    // Form the table using the projects extracted from the JSON file
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "projectListTVC") as? projectListTVC else { return UITableViewCell() }
        
        cell.title.text = ViewController.users[indexPath.row].title
        
        if let imageURL = URL(string: ViewController.users[indexPath.row].logo){
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? listDetailsVC{
            destination.selected_user = ViewController.users[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}
