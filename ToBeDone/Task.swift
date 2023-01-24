//
//  Task.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 16.11.2022.
//

import UIKit


protocol CompletableTaskDelegate: AnyObject{
    func pressComplete(_ button: UIButton?)
}

class Task: UIView {
    private enum PlaceholderPosition {
        case raised, lowered
    }
    
    var img : UIImage = UIImage(named: "editIcon")!
    var color : UIColor = .black
    var buttonDelegate : CompletableTaskDelegate?
    private lazy var taskName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .gray
        return label
    }()
    
    private lazy var descrition: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        label.text = "description"
        return label
    }()
    
    private lazy var icon: UIImageView = {
        let button = UIImageView()
        button.image = img
        return button
    }()
    
    private lazy var hour: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.text = "10:00-12:00"
        return label
    }()
    
    lazy var checkbox: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.borderColor = color.cgColor
        button.layer.borderWidth = 3
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addConstraintsToSubviews()
        subscribeToActions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        addConstraintsToSubviews()
        subscribeToActions()
    }
    
    func configureTask(with task: TaskModel, color : UIColor, delegate : CompletableTaskDelegate, tag: Int) {
        taskName.text = task.title
        descrition.text = task.description
        hour.text = task.time
        self.checkbox.layer.borderColor = color.cgColor
        self.icon.backgroundColor = color
        self.descrition.textColor = color
        self.taskName.textColor = color
        self.buttonDelegate = delegate
        self.checkbox.tag = tag
        self.layer.borderColor = color.cgColor
    }
    
    @objc private func pressCompleteButton () {
        buttonDelegate?.pressComplete(checkbox)
    }
    
    private func subscribeToActions() {
        checkbox.addTarget(self, action: #selector(pressCompleteButton), for: .touchUpInside)
    }
    
    private func addSubviews() {
        addSubview(taskName)
        addSubview(checkbox)
        addSubview(hour)
        addSubview(icon)
        addSubview(descrition)
        
    }
    
    private func addConstraintsToSubviews() {
        self.layer.borderWidth = 2
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = 10
        layoutPlaceholder()
        layoutCheckbox()
        layoutHour()
        layoutIcon()
        layoutDescription()
    }
    
    private func layoutPlaceholder() {
        taskName.translatesAutoresizingMaskIntoConstraints = false
        taskName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 75).isActive = true
        taskName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true

    }
    
    private func layoutHour() {
        hour.translatesAutoresizingMaskIntoConstraints = false
        hour.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 75).isActive = true
        hour.topAnchor.constraint(equalTo: descrition.topAnchor, constant: 20).isActive = true
    }
    
    private func layoutCheckbox() {
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        checkbox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        checkbox.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        checkbox.widthAnchor.constraint(equalToConstant: 20).isActive = true
        checkbox.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    private func layoutIcon() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        icon.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        icon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
    }
    
    private func layoutDescription() {
        descrition.translatesAutoresizingMaskIntoConstraints = false
        descrition.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 75).isActive = true
        descrition.topAnchor.constraint(equalTo: taskName.topAnchor, constant: 25).isActive = true
    }
}
