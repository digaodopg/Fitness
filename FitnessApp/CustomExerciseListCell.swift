//
//  CustomExerciseListCell.swift
//  FitnessApp
//
//  Created by Giorgio Doganiero on 10/28/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit

class CustomExerciseListCell: UITableViewCell {

    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var exerciseName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
