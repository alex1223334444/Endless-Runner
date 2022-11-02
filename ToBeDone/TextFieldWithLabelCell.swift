//
//  TextFieldWithLabelCell.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 31.10.2022.
//

import UIKit

class TextFieldWithLabelCell: UITableViewCell {

    @IBOutlet weak var textfield: TextFieldWithLabel!
    func configureTextFieldCell(_ placeholder: String, tag: Int = 0 ,secure: Bool,delegate: TextFieldWithLabelDelegate){
        textfield.configureTextField(with: placeholder, secured: secure, tag: tag, delegate: delegate)
      }

}
