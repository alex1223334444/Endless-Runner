//
//  RegisterViewController.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 31.10.2022.
//

import UIKit

class RegisterViewController: UIViewController, TextFieldWithLabelDelegate, ButtonDelegate {
    func buttonTouchUpInside() {
        print(user)
    }
    
    @IBOutlet weak var tableView: UITableView!
    private var user : UserModel = UserModel()
    private var labels : [String] = ["First name", "Last name","Username","Password","Confirm password"]
    private var buttonCell : ButtonCell?
    func changeText(_ textContent: UITextField?) {
        guard let text = textContent?.text else {
            return
        }
        switch textContent?.tag {
        case 0 :
            user.firstName = text
        case 1:
            user.lastName = text
        case 2:
            user.username = text
        case 3:
            user.password = text
        case 4:
            user.confirm = text
        default:
            print(user)
        }
        buttonCell?.enableButton(enabled: true)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.layer.cornerRadius = 10
        
    }
    
}


extension RegisterViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count + 1// + 3 because I have 6 textfields (textfields.cont) + 2 checkboxes + 1 button
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < labels.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "textfield", for: indexPath) as? TextFieldWithLabelCell else {
                return UITableViewCell()
            }
            cell.configureTextFieldCell(labels[indexPath.row], tag: indexPath.row, secure: false, delegate : self)
            cell.showsReorderControl = true
            return cell
            
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "button", for: indexPath) as? ButtonCell else {
                return UITableViewCell()
            }
            cell.configureButton(title: "Submit", delegate: self)
            cell.showsReorderControl = true
            buttonCell = cell
            return cell
        }
        
        
        
    }
}


struct UserModel {
    var firstName : String = ""
    var lastName : String = ""
    var username : String = ""
    var password : String = ""
    var confirm : String = ""
}
