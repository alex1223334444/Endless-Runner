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
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    var numbers : NumberOfTasks? = NumberOfTasks()
    private var uid = ""
    private var user = User(username: "", lastName: "", uid: "", firstName: "", totalTasks: 0, doneTasks: 0, coins: 0, background1: 0, background2: 0, background3: 0, background4: 0, avatar1: 0, avatar2: 0, avatar3: 0, avatar4: 0)

    override var preferredStatusBarStyle: UIStatusBarStyle{
        .darkContent
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
                if let done = self.user.doneTasks, let coins = self.user.coins, let firstname = self.user.firstName, let lastname = self.user.lastName {
                    DispatchQueue.main.async {
                        self.doneTasks.setTitle("Tasks done: \(done)", for: .normal)
                        self.unfinishedTasks.setTitle("Coins obtained: \(coins)", for: .normal)
                        self.name.text = "\(firstname) \(lastname)"
                        self.email.text = self.user.username
                    }
                }
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
