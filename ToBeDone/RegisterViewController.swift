//
//  RegisterViewController.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 31.10.2022.
//

import UIKit

class RegisterViewController: UIViewController, TextFieldWithLabelDelegate {
    @IBOutlet weak var tableView: UITableView!
    func changeText(_ textContent: UITextField?) {
        print("")
    }
    
    func changeLabel(_ label: UILabel?) {
        print("")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self 
    }
}


extension RegisterViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 // + 3 because I have 6 textfields (textfields.cont) + 2 checkboxes + 1 button
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "textfield", for: indexPath) as? TextFieldWithLabelCell else {
                return UITableViewCell()
            }
            //let label = self.textfields[indexPath.row]
            //let error = self.errorLabels[indexPath.row]
           
                
        cell.configureTextFieldCell("label placeholder", error: " ", tag: indexPath.row, secure: false, delegate : self)
            cell.showsReorderControl = true
            return cell
        
        
    }
}
/*
 // Only override draw() if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 override func draw(_ rect: CGRect) {
 // Drawing code
 }
 */

