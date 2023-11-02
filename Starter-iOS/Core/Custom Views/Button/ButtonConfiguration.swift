//
//  ButtonConfiguration.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 02/11/2023.
//

import UIKit

struct ButtonConfiguration {
    var title: String
    var titleColor: UIColor
    var font: UIFont
    var backgroundColor: UIColor
    var cornerRadius: CGFloat
    var border: Border?
    var shadow: Shadow?
    var gradient: Gradient?
    
    struct Border {
        var color: UIColor
        var width: CGFloat
    }
    
    struct Shadow {
        var color: UIColor
        var offset: CGSize
        var opacity: Float
        var radius: CGFloat
    }
    
    struct Gradient {
        var colors: [CGColor]
        var stops: [NSNumber]? // Optional gradient stops
    }
}
