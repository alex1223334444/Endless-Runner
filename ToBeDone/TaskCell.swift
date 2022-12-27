//
//  TaskCell.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 16.11.2022.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var task: Task!
    func configureTextFieldCell(_ requestedTask: TaskModel, tag: Int = 0, color: UIColor){
        task.layer.cornerRadius = 10
        task.configureTextField(with: requestedTask, color: color)
        self.tag = tag
      }
}
