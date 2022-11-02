//
//  MainViewController.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 26.10.2022.
//  Modified by Andrei Tatucu on 02.11.2022. 
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = loginButton.bounds.size.height/2
        registerButton.layer.cornerRadius = registerButton.bounds.size.height/2
        loginButton.isHidden = true
        registerButton.isHidden = true
    }
    
    func animateLogo()
    {
        UIView.animate(withDuration: 3.0, delay: 1.2, options: .curveLinear, animations: {
            self.logo.translatesAutoresizingMaskIntoConstraints = false
            self.logo.centerYAnchor.constraint(equalTo: self.logo.centerYAnchor, constant: -100).isActive = true
            self.logo.bottomAnchor.constraint(equalTo: self.logo.bottomAnchor, constant: 30).isActive = true
            self.logo.topAnchor.constraint(equalTo: self.logo.topAnchor, constant: 100).isActive = true
            self.logo.centerXAnchor.constraint(equalTo: self.logo.centerXAnchor, constant: 0).isActive = true

            
            self.logo.layoutIfNeeded()
        }, completion: { success in
           print("succes animation")
        })
    }
    
    func showButtons()
    {
        self.loginButton.isHidden = false
        self.registerButton.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateLogo()
        showButtons()
    }
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var logo: UIView!
}
