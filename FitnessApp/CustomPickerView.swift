//
//  CustomPickerView.swift
//  Fitness
//
//  Created by Giorgio Doganiero on 8/21/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit

class CustomPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let numberItems = 60
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
        //fatalError("This class does not support NSCoding")
    }
    
    func setup() {
        self.delegate = self
        self.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberItems
    }
    
    
}
