//
//  TaskCell.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 16.11.2022.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var task: Task!
    var tick : UIImage = UIImage(named: "tick")!

    func configureTaskCell(_ requestedTask: TaskModel, tag: Int = 0, color: UIColor, finished : Bool, delegate : CompletableTaskDelegate){
        task.layer.cornerRadius = 10
        task.configureTask(with: requestedTask, color: color, delegate: delegate, tag : tag)
        //task.backgroundColor = Theme.current.background
        self.tag = tag
        self.tintColor = color
        if finished == true{
            self.task.checkbox.setImage(tick, for: .normal)
        }
        else {
            self.task.checkbox.setImage(nil, for: .normal)
        }
      }
}
