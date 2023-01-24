//
//  SettingsViewController.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 05.12.2022.
//

import UIKit
import StoreKit
import SwiftUI
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var doneButton: UIButton!
    var numbers : NumberOfTasks? = NumberOfTasks()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    
    @IBAction func rate(_ sender: Any) {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                SKStoreReviewController.requestReview(in: scene)
            }
            
        }
    }
    
    @IBAction func darkMode(_ sender: Any) {
        view.backgroundColor = .black
    }
    
     
    @IBAction func goToProfile(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Profile", bundle:nil)
        let profileViewController = storyBoard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        profileViewController.numbers = self.numbers
        self.present(profileViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let err {
            print(err)
        }
    }
}

