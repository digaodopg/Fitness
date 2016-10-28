//
//  TableViewHeader.swift
//  FitnessApp
//
//  Created by Giorgio Doganiero on 9/19/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit

class TableViewHeader: UITableViewHeaderFooterView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "THIS WEEK"
        label.textColor = UIColor.customGray()
        label.font = UIFont(name: "Oswald-Bold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Schedule", for: .normal)
        button.setTitleColor(UIColor.customDarkGray(), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Oswald-Regular", size: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        headerSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func headerSetup() {
        addSubview(titleLabel)
        //addSubview(editButton)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": titleLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": titleLabel]))
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": editButton]))
        
        //editButton.addTarget(self, action: #selector(TableViewHeader.editButtonPressed), for: .touchUpInside)
    }
    
    func editButtonPressed() {
        //myTableView.editScheduleAction()
    }
}
