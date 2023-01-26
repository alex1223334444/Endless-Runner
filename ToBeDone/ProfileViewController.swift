//
//  ProfileViewController.swift
//  ToBeDone
//
//  Created by Tatucu on 1/5/23.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var doneTasks: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var unfinishedTasks: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var task1: UIButton!
    var numbers : NumberOfTasks? = NumberOfTasks()
    private var uid = ""
    private var user = User(username: "", lastName: "", uid: "", firstName: "", totalTasks: 0, doneTasks: 0, coins: 0, background1: 0, background2: 0, background3: 0, background4: 0, avatar1: 0, avatar2: 0, avatar3: 0, avatar4: 0)

    @IBOutlet weak var doneTask1: UIButton!
    @IBAction func doneTask2(_ sender: Any) {
        let refreshAlert = UIAlertController(title: "Have you done this task?", message: "Good job!", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Cancel")
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [self] (action: UIAlertAction!) in
            
            
            user.coins! += 20
            updateUser(updatedUser: user) { data, response, error in
                if let error = error {
                    let alert = UIAlertController(title: "Error at updating user data. Try again please.", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                    return
                }
            }
            
            
        }))
        
        self.present(refreshAlert, animated: true, completion: nil)
        
        
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .darkContent
    }

    @IBAction func doneTask1(_ sender: Any) {
        let refreshAlert = UIAlertController(title: "Have you done this task?", message: "Good job!", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Cancel")
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [self] (action: UIAlertAction!) in
            
            
            user.coins! += 30
            updateUser(updatedUser: user) { data, response, error in
                if let error = error {
                    let alert = UIAlertController(title: "Error at updating user data. Try again please.", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                    return
                }
            }
            
            
        }))
        
        self.present(refreshAlert, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func doneTask3(_ sender: Any) {
        let refreshAlert = UIAlertController(title: "Have you done this task?", message: "Good job!", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Cancel")
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [self] (action: UIAlertAction!) in
            
            
            user.coins! += 10
            updateUser(updatedUser: user) { data, response, error in
                if let error = error {
                    let alert = UIAlertController(title: "Error at updating user data. Try again please.", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                    return
                }
            }
            
            
        }))
        
        self.present(refreshAlert, animated: true, completion: nil)
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.hidesBackButton = true
        avatar.layer.cornerRadius = avatar.frame.width/2
        avatar.layer.borderWidth = 2
        if let total = numbers?.totalTasks, let unfinished = numbers?.uncompleted{
            doneTasks.text = "Tasks done: \(total - unfinished)"
            //unfinishedTasks.setTitle("Unfinished tasks: \(unfinished)", for: .normal)
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
                        self.doneTasks.text = "Tasks done: \(done)"
                        //self.unfinishedTasks.setTitle("Coins obtained: \(coins)", for: .normal)
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
