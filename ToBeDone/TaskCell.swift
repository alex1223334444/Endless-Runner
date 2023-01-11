//
//  TaskCell.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 16.11.2022.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var task: Task!
    func configureTaskCell(_ requestedTask: TaskModel, tag: Int = 0, color: UIColor, delegate : CompletableTaskDelegate){
        task.layer.cornerRadius = 10
        task.configureTask(with: requestedTask, color: color, delegate: delegate, tag : tag)
        self.tag = tag
        self.tintColor = color
      }
}
