//
//  FontAwesome+SL.swift
//  shopping-list
//
//  Created by Mason Phillips on 8/12/20.
//

import UIKit

enum FAFont {
    case light, regular, solid
    
    var font: UIFont {
        let font: String
        switch self {
        case .solid  : font = "FontAwesome5Pro-Solid"
        case .regular: font = "FontAwesome5Pro-Regular"
        case .light  : font = "FontAwesome5Pro-Light"
        }
        
        return (UIFont(name: font, size: 20) ?? .systemFont(ofSize: 20))
    }
}
