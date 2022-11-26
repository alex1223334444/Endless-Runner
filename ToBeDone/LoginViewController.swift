//
//  LoginViewController.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 26.11.2022.
//

import UIKit

class LoginViewController: UIViewController, TextFieldWithLabelDelegate {
    func changeText(_ textContent: UITextField?) {
         
    }
    

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var email: TextFieldWithLabel!
    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var forgetPassword: UIButton!
    @IBOutlet weak var password: TextFieldWithLabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerLink: UIButton!
    @IBOutlet weak var gmailLogin: UIButton!
    @IBOutlet weak var facebookLogin: UIButton!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 10
        email.configureTextField(with: "Email", delegate: self)
        password.configureTextField(with: "Password", delegate: self)
        loginButton.layer.cornerRadius = 8
        gmailLogin.layer.cornerRadius = gmailLogin.frame.width/2
        facebookLogin.layer.cornerRadius = facebookLogin.frame.width/2
        self.hideKeyboardWhenTappedAround()
    }
    

}
