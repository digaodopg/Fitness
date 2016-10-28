//
//  ProfileViewController.swift
//  FitnessApp
//
//  Created by Giorgio Doganiero on 10/26/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func settingButtonPressed() {
        performSegue(withIdentifier: "ShowSettings", sender: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
