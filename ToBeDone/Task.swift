//
//  Task.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 16.11.2022.
//

import UIKit

class Task: UIView {
    private enum PlaceholderPosition {
        case raised, lowered
    }
    var img : UIImage = UIImage(named: "editIcon")!
    var color : UIColor = .black
    
    private lazy var taskName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        label.text = "placeholder"
        return label
    }()
    
    private lazy var icon: UIButton = {
        let button = UIButton()
        button.setImage(img, for: .normal)
        return button
    }()
    
    private lazy var hour: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.text = "10:00-12:00"
        return label
    }()
    
    private lazy var checkbox: UIButton = {
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
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        addConstraintsToSubviews()
    }
    
    func configureTextField(with placeholder: String, keyboardType: UIKeyboardType = .default, secured: Bool = false, color : UIColor) {
        taskName.text = placeholder
        self.color = color
        
    }
    
    private func addSubviews() {
        addSubview(taskName)
        addSubview(checkbox)
        addSubview(hour)
        addSubview(icon)
        
    }
    
    private func addConstraintsToSubviews() {
        self.layer.borderWidth = 2
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = 10
        layoutPlaceholder()
        layoutCheckbox()
        layoutHour()
        layoutIcon()
    }
    
    private func layoutPlaceholder() {
        taskName.translatesAutoresizingMaskIntoConstraints = false
        taskName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 75).isActive = true
        taskName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true

    }
    
    private func layoutHour() {
        hour.translatesAutoresizingMaskIntoConstraints = false
        hour.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 75).isActive = true
        hour.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10).isActive = true
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
}
