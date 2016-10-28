//
//  CustomizableLabel.swift
//  FitnessApp
//
//  Created by Giorgio Doganiero on 10/26/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit

@IBDesignable class CustomizableLable: UILabel {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        
        didSet {
            
            layer.cornerRadius = cornerRadius
            
        }
        
    }
    
}
