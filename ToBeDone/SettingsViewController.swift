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
    
     @IBAction func logout(_ sender: Any) {
         //navigationController?.popToRootViewController(animated: true)
         performSegue(withIdentifier: "logout", sender: nil)
     }
     
}

