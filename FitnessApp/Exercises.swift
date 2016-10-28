//
//  Exercises.swift
//  FitnessApp
//
//  Created by Giorgio Doganiero on 9/23/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit

class Exercises: NSObject {
    //var name: String?
    var muscle: String?
    var level: String?
    var rightPic: String?
    var leftPic: String?
    //var guide: String?
}

class SafeJsonObject: NSObject {
    
    override func setValue(_ value: Any?, forKey key: String) {
        let selectorString = "set\(key.uppercased().characters.first!)\(String(key.characters.dropFirst()))"
        let selector = Selector(selectorString)
        if responds(to: selector) {
            super.setValue(value, forKey: key)
        }
    }
}
