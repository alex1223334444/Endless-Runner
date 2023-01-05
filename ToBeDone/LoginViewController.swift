//
//  LoginViewController.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 26.11.2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, TextFieldWithLabelDelegate {
    func changeText(_ textContent: UITextField?) {
        guard let text = textContent?.text else {
            return
        }
        switch textContent?.tag {
        case 0 :
            username = text
        case 1:
            pass = text
        default:
            print(text)
        }
        if username != "" && pass != "" {
            loginButton.isEnabled = true
        }
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
    private var username = ""
    private var pass = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 10
        email.configureTextField(with: "Email",tag: 0, delegate: self)
        password.configureTextField(with: "Password",secured: true, tag: 1, delegate: self)
        loginButton.layer.cornerRadius = 8
        gmailLogin.layer.cornerRadius = gmailLogin.frame.width/2
        facebookLogin.layer.cornerRadius = facebookLogin.frame.width/2
        self.hideKeyboardWhenTappedAround()
        loginButton.isEnabled = false
    }
    
    @IBAction func signIn(_ sender: Any) {
        Auth.auth().signIn(withEmail: username, password: pass) { (authResult, error) in
            if let error = error {
                let alert = UIAlertController(title: "Error on login", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "login", sender: self)
            }
        }
    }
    
}
