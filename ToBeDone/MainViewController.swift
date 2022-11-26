//
//  MainViewController.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 26.10.2022.
//  Modified by Andrei Tatucu on 02.11.2022. 
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var logo: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = loginButton.bounds.size.height/2
        registerButton.layer.cornerRadius = registerButton.bounds.size.height/2
        loginButton.isHidden = true
        registerButton.isHidden = true
        logo.layer.cornerRadius = logo.frame.width/2
        
    }
    
    func animateLogo()
    {
        UIView.animate(withDuration: 2.0, delay: 1.2, options: .curveLinear, animations: {
            self.logo.transform = CGAffineTransform(translationX: 0, y: -300)
            self.logo.transform = self.logo.transform.scaledBy(x: 0.75, y: 0.75)
        }, completion: { success in
           print("succes animation")
            self.showButtons()
        })
    }
    
    func showButtons()
    {
        self.loginButton.isHidden = false
        self.registerButton.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateLogo()
    }
}
