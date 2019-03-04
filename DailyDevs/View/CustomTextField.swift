//
//  CustomTextField.swift
//  DailyDevs
//
//  Created by Tifo Audi Alif Putra on 26/02/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit
@IBDesignable

class CustomTextField: UITextField {
    
    var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    override func awakeFromNib() {
        self.setupView()
    }

    private func setupView() {
        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0.9878045917, blue: 0.9835746884, alpha: 1)])
        self.attributedPlaceholder = placeholder
    }

}
