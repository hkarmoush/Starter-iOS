//
//  TextfieldFactory.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 02/11/2023.
//

import UIKit

class TextFieldFactory {
    
    static func createTextField(with style: TextFieldConfiguration) -> UITextField {
        let textField = UITextField(frame: .zero)
        configure(textField: textField, with: style)
        return textField
    }
    
    private static func configure(textField: UITextField, with style: TextFieldConfiguration) {
        textField.text = style.text
        textField.placeholder = style.placeholder
        textField.font = style.font
        textField.textColor = style.textColor
        textField.backgroundColor = style.backgroundColor
        textField.textAlignment = style.textAlignment
        textField.keyboardType = style.keyboardType
        textField.isSecureTextEntry = style.isSecureTextEntry
        applyBorder(textField: textField, with: style.border)
    }
    
    private static func applyBorder(textField: UITextField, with border: TextFieldConfiguration.Border) {
        textField.layer.borderColor = border.color.cgColor
        textField.layer.borderWidth = border.width
        textField.layer.cornerRadius = border.cornerRadius
    }
}
