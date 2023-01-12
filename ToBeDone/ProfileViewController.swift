//
//  ProfileViewController.swift
//  ToBeDone
//
//  Created by Tatucu on 1/5/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var doneTasks: UIButton!
    @IBOutlet weak var unfinishedTasks: UIButton!
    var numbers : NumberOfTasks? = NumberOfTasks()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let total = numbers?.totalTasks, let unfinished = numbers?.uncompleted{
            doneTasks.setTitle("Tasks done: \(total - unfinished)", for: .normal)
            unfinishedTasks.setTitle("Unfinished tasks: \(unfinished)", for: .normal)
        }
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
