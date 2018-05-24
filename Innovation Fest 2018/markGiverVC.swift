//
//  markGiverVC.swift
//  Innovation Fest 2018
//
//  Created by Taha Mahmut Yazici on 15/01/2018.
//  Copyright © 2018 TH Productions. All rights reserved.
//

import UIKit

class markGiverVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {

    
    @IBOutlet weak var feedback_txt: UITextView!
    @IBOutlet weak var textLabel1: UILabel!
    @IBOutlet weak var textLabel2: UILabel!
    @IBOutlet weak var textLabel3: UILabel!
    @IBOutlet weak var textLabel4: UILabel!
    
    @IBOutlet weak var pickerView1: UIPickerView!
    @IBOutlet weak var pickerView2: UIPickerView!
    @IBOutlet weak var pickerView3: UIPickerView!
    @IBOutlet weak var pickerView4: UIPickerView!
    
    var saved_data = CoreDataHandler.fetchObject()
    
    let marks = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    var innovationMark = "1"
    var teamworkMark = "1"
    var enterpMark = "1"
    var inspirationMark = "1"
    
    @IBAction func submissionButton(_ sender: UIButton) {
        if let i = saved_data?.index(where: { $0.title == listDetailsVC.project_title }) {
            CoreDataHandler.deleteObject(saved_p: saved_data![i])
            print("Deleted")
        }

        // Save the marks given
        CoreDataHandler.saveObject(title: listDetailsVC.project_title,
                                   innovation: innovationMark,
                                   teamwork: teamworkMark,
                                   enterp: enterpMark,
                                   inspiration: inspirationMark)
        
        listDetailsVC.seguePerformed = true
        
        performSegue(withIdentifier: "unWindToDetails", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.feedback_txt.delegate = self;
        self.pickerView1.dataSource = self;
        self.pickerView1.delegate = self;
        
        self.pickerView2.dataSource = self;
        self.pickerView2.delegate = self;
        
        self.pickerView3.dataSource = self;
        self.pickerView3.delegate = self;
        
        self.pickerView4.dataSource = self;
        self.pickerView4.delegate = self;
        
        textLabel1.text = "Inspiration"
        textLabel2.text = "Innovation"
        textLabel3.text = "Entrepreneurship"
        textLabel4.text = "Teamwork"
        
        self.feedback_txt.text = "Write your feedback & comments here"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { return marks.count }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { return marks[row] }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView1 {
            inspirationMark = marks[row]
        } else if pickerView == pickerView2 {
            innovationMark = marks[row]
        } else if pickerView == pickerView3 {
            enterpMark = marks[row]
        } else if pickerView == pickerView4 {
            teamworkMark = marks[row]
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if feedback_txt.text == "Write your feedback & comments here"
        {
            feedback_txt.text = ""
            feedback_txt.textColor = UIColor.black
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"
        {
            feedback_txt.resignFirstResponder()
        }
        return true
    }
}
