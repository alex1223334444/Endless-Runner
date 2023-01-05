//
//  EditViewController.swift
//  ToBeDone
//
//  Created by user230454 on 1/4/23.
//

import UIKit

class EditViewController: UIViewController {

    var task : TaskModel? = TaskModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("aici incepe")
        print(task)
        print("aici se termina")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
