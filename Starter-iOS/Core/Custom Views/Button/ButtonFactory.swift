//
//  ButtonFactory.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 02/11/2023.
//

import UIKit

class ButtonFactory {
    
    static func create(with style: ButtonConfiguration) -> UIButton {
        let button = UIButton(type: .system)
        configure(button: button, with: style)
        applyBorder(button: button, with: style.border)
        applyShadow(button: button, with: style.shadow)
        applyGradient(button: button, with: style.gradient)
        return button
    }
    
    private static func configure(button: UIButton, with style: ButtonConfiguration) {
        button.setTitle(style.title, for: .normal)
        button.setTitleColor(style.titleColor, for: .normal)
        button.titleLabel?.font = style.font
        button.backgroundColor = style.backgroundColor
        button.layer.cornerRadius = style.cornerRadius
    }
    
    private static func applyBorder(button: UIButton, with border: ButtonConfiguration.Border?) {
        guard let border = border else { return }
        button.layer.borderWidth = border.width
        button.layer.borderColor = border.color.cgColor
    }
    
    private static func applyShadow(button: UIButton, with shadow: ButtonConfiguration.Shadow?) {
        guard let shadow = shadow else { return }
        button.layer.shadowColor = shadow.color.cgColor
        button.layer.shadowOffset = shadow.offset
        button.layer.shadowOpacity = shadow.opacity
        button.layer.shadowRadius = shadow.radius
    }
    
    private static func applyGradient(button: UIButton, with gradient: ButtonConfiguration.Gradient?) {
        guard let gradient = gradient else { return }
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradient.colors
        gradientLayer.locations = gradient.stops
        gradientLayer.frame = button.bounds
        gradientLayer.cornerRadius = button.layer.cornerRadius
        button.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
