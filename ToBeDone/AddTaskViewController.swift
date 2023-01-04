//
//  AddTaskViewController.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 25.12.2022.
//

import UIKit

class AddTaskViewController: UIViewController, TextFieldWithLabelDelegate {
    func changeText(_ textContent: UITextField?) {
        if let text=textContent?.text
        {
            print(text)
        }
    }
    
    @IBOutlet weak var PriorityPicker: UISegmentedControl!
    @IBOutlet weak var TrackedBtn: UISwitch!
    @IBOutlet weak var AlarmBtn: UISwitch!
    @IBOutlet weak var CalendarPkr: UIDatePicker!
    @IBAction func Tracked(_ sender: Any) {
    }
    
    @IBAction func Priority(_ sender: Any) {
    }
    
    @IBAction func Alarm(_ sender: Any) {
    }
    
    @IBAction func Calendar(_ sender: Any) {
    }
    
    @IBOutlet weak var textfield: TextFieldWithLabel!
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var TaskTitle: TextFieldWithLabel!
    
    @IBOutlet weak var TaskDescription: TextFieldWithLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = 8
        // Do any additional setup after loading the view.
        
        TaskTitle.configureTextField(with: "Title", tag:0, delegate: self)
        TaskDescription.configureTextField(with: "Description", tag:1, delegate: self)    }
    
     @IBAction func pressSubmit(_ sender: Any) {
         print("submit")
     }
     
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
