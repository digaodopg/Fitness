//
//  PickerViewContainer.swift
//  Fitness
//
//  Created by Giorgio Doganiero on 8/22/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit

protocol PickerViewDelegate : class {
    func setbuttonEnable(_ state: Bool)
    func intervalButtonPressed(_ color: UIColor)
}

class PickerViewContainer: UIView {
    
    let bound = UIScreen.main.bounds
    weak var delegate: PickerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        //top bar
        let toolbar = UIToolbar()
        toolbar.clipsToBounds = true
        toolbar.barStyle = .default
        toolbar.isTranslucent = false
        toolbar.barTintColor = UIColor.customGreen()
        toolbar.tintColor = UIColor.customDarkGray()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(PickerViewContainer.hidePicker))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(PickerViewContainer.hidePicker))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([cancelButton, space, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true

        //custom picker
        let picker = CustomPickerView()
        picker.backgroundColor =  UIColor.white.withAlphaComponent(0.95)
        picker.frame = CGRect(x: 0, y: 44, width: bound.size.width, height: (bound.size.height / 2) - 55)
        
        addSubview(toolbar)
        addSubview(picker)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
        //fatalError("This class does not support NSCoding")
    }
    
    @objc func hidePicker() {
        UIView.animate(withDuration: 0.5, animations: {self.frame =
            CGRect(x: self.frame.origin.x,
                y: self.frame.origin.y + self.frame.size.height,
                width: self.frame.size.width,
                height: self.frame.size.height)})
        //change next button enable to true
        //self.hidden = true
        delegate?.setbuttonEnable(true)
        delegate?.intervalButtonPressed(UIColor.customLightGray())
    }
    
}


