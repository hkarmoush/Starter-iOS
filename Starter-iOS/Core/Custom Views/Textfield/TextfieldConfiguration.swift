//
//  TextfieldConfiguration.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 02/11/2023.
//

import UIKit

struct TextFieldConfiguration {
    
    var text: String?
    var placeholder: String?
    var font: UIFont
    var textColor: UIColor
    var backgroundColor: UIColor
    var border: Border
    var textAlignment: NSTextAlignment
    var keyboardType: UIKeyboardType
    var isSecureTextEntry: Bool

    struct Border {
        var color: UIColor
        var width: CGFloat
        var cornerRadius: CGFloat
    }
    
}
