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
    var numbers : NumberOfTasks? = NumberOfTasks()
    
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var rateButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.current.view
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = Theme.current.view
    }
    
    @IBAction func rate(_ sender: Any) {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                SKStoreReviewController.requestReview(in: scene)
            }
            
        }
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

