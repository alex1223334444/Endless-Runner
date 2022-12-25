//
//  AddTaskViewController.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 25.12.2022.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var textfield: TextFieldWithLabel!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = 8
        // Do any additional setup after loading the view.
    }
    
     @IBAction func pressSubmit(_ sender: Any) {
         print("submit")
     }
     
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}
