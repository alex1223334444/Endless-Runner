//
//  ButtonCell.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 03.11.2022.
//

import UIKit

class ButtonCell: UITableViewCell {
    
    @IBOutlet weak var button: Button!
    func configureButton(title: String, delegate : ButtonDelegate){
        button.configureButton(title: title,delegate: delegate)
    }
    
    func enableButton(enabled : Bool){
        button.button.isEnabled = enabled
    }
    
}
