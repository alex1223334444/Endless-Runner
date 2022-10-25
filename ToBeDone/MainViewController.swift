//
//  MainViewController.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 26.10.2022.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = loginButton.bounds.size.height/2
        registerButton.layer.cornerRadius = registerButton.bounds.size.height/2
        loginButton.isHidden = true
        registerButton.isHidden = true
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var logo: UIView!
    
    


}
