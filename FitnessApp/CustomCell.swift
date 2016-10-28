//
//  CustomCell.swift
//  FitnessApp
//
//  Created by Giorgio Doganiero on 9/16/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    //let myTableView: ViewController?
    
    let cellTitleLabel: UILabel = {
        let label = UILabel()
        //label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Oswald-Regular", size: 16)
        return label
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "M"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Oswald-Regular", size: 16)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Oswald-Light", size: 16)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        labelSetup()
        self.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func labelSetup() {
        //dayLabel.text = getDayOfWeek()
        
        addSubview(dayLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dayLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]-22-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dayLabel]))
        
        addSubview(dateLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dateLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-22-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dateLabel]))
        
        addSubview(cellTitleLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": cellTitleLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": cellTitleLabel]))
    }
    
    func getDayOfWeek() -> String {
        let today = NSDate()
        let myCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        let weekDay = myCalendar.component(.weekday, from: today as Date)
        var day = ""
        
        switch weekDay {
        case 1:
            day = "S"
            break
        case 2:
            day = "M"
            break
        case 3:
            day = "T"
            break
        case 4:
            day = "W"
            break
        case 5:
            day = "TH"
            break
        case 6:
            day = "F"
            break
        case 7:
            day = "S"
            break
        default:
            break
        }
        
        return day
    }
    
    func getDateOfWeek() -> Int {
        return 1
    }
}
