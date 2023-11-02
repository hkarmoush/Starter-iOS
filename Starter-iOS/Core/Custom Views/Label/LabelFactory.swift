//
//  LabelFactory.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 02/11/2023.
//

import UIKit

class LabelFactory {

    static func create(with style: LabelStyle) -> UILabel {
        let label = UILabel()
        configure(label: label, with: style)
        return label
    }
    
    private static func configure(label: UILabel, with style: LabelStyle) {
        label.text = style.text
        label.textColor = style.textColor
        label.font = style.font
        label.backgroundColor = style.backgroundColor
        label.textAlignment = style.alignment
        label.numberOfLines = style.numberOfLines
    }
    
}
