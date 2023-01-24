//
//  ProfileViewController.swift
//  ToBeDone
//
//  Created by Tatucu on 1/5/23.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var doneTasks: UIButton!
    @IBOutlet weak var unfinishedTasks: UIButton!
    var numbers : NumberOfTasks? = NumberOfTasks()
    private var uid = ""
    private var user = User(username: "", lastName: "", uid: "", firstName: "", totalTasks: 0, doneTasks: 0, coins: 0)

    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.hidesBackButton = true
        avatar.layer.cornerRadius = avatar.frame.width/2
        avatar.layer.borderWidth = 2
        if let total = numbers?.totalTasks, let unfinished = numbers?.uncompleted{
            doneTasks.setTitle("Tasks done: \(total - unfinished)", for: .normal)
            unfinishedTasks.setTitle("Unfinished tasks: \(unfinished)", for: .normal)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = Auth.auth().currentUser {
            let id = user.uid
            uid = id
            print(id)
        } else {
            //
        }
        getUser(id: uid) { result in
            switch result {
            case .success(let user):
                self.user = user[0]
                print(self.user)
                break
            case .failure(let error):
                print(error)
                break
            }
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
