//
//  CustomizableButton.swift
//  FitnessApp
//
//  Created by Giorgio Doganiero on 11/7/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit

@IBDesignable class CustomizableButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        
        didSet {
            
            layer.cornerRadius = cornerRadius
            
        }
        
    }
    
}
