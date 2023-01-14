//
//  SettingsViewController.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 05.12.2022.
//

import UIKit
import StoreKit
import SwiftUI

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var doneButton: UIButton!
    var numbers : NumberOfTasks? = NumberOfTasks()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true)
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
    @IBAction func logout(_ sender: Any) {
         //navigationController?.popToRootViewController(animated: true)
         performSegue(withIdentifier: "logout", sender: nil)
     }
     
    @IBAction func goToProfile(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Profile", bundle:nil)
        let profileViewController = storyBoard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        profileViewController.numbers = self.numbers
        self.present(profileViewController, animated: true, completion: nil)
    }
}

