//
//  TaskCell.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 16.11.2022.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var task: Task!
    func configureTextFieldCell(_ placeholder: String, tag: Int = 0 ,secure: Bool,delegate: TextFieldWithLabelDelegate, color: UIColor){
        task.layer.cornerRadius = 10
        task.configureTextField(with: placeholder, secured: secure, color: color)
      }
}
