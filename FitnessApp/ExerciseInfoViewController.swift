//
//  ExerciseInfoViewController.swift
//  FitnessApp
//
//  Created by Giorgio Doganiero on 10/12/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit

class ExerciseInfoViewController: UIViewController {
    
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var exerciseTitle: UILabel!
    @IBOutlet weak var mainMuscle: UILabel!
    @IBOutlet weak var guide: UITextView!
    
    var backButton: UIBarButtonItem!
    var image = UIImage()
    var text = String()
    
    var passedValue: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
        
        self.leftImage.image = self.image
        self.exerciseTitle.text = self.text
        self.guide.scrollRangeToVisible(NSMakeRange(0, 0))
        
        //hide back button
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        //back button
        backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(ExerciseInfoViewController.goToPreviousView))
        backButton.tintColor = mainColor()
        navigationItem.leftBarButtonItem = backButton
        
        exerciseSelected()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guide.setContentOffset(.zero, animated: false)
    }
    
    func goToPreviousView() {
        _ = navigationController?.popViewController(animated: true)
        //unhide tab bar
        tabBarController?.tabBar.isHidden = false
    }
    
}
