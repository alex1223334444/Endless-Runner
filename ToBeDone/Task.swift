//
//  Task.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 16.11.2022.
//

import UIKit

class Task: UIView {
    private var placeholderYConstraint: NSLayoutConstraint?
    private enum PlaceholderPosition {
        case raised, lowered
    }
    
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "placeholder"
        return label
    }()
    
    
    private lazy var bottomBorder: UIView = {
        let border = UIView()
        border.backgroundColor = .gray
        return border
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
    
    func configureTextField(with placeholder: String, keyboardType: UIKeyboardType = .default, secured: Bool = false, tag: Int = 0, delegate : TextFieldWithLabelDelegate) {
        placeholderLabel.text = placeholder
        
    }
    
    
    private func addSubviews() {
        addSubview(placeholderLabel)
        addSubview(bottomBorder)
    }
    
    
    private func animatePlaceholderUp() {
        self.placeholderYConstraint?.constant = -16
    }
    
   
    
    private func addConstraintsToSubviews() {
        layoutBorder()
        layoutPlaceholder()
    }
            
    
    private func layoutBorder() {
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        bottomBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
    private func layoutPlaceholder() {
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        placeholderYConstraint?.isActive = true
    }
}
