//
//  WelcomeOneViewController.swift
//  FitnessApp
//
//  Created by Giorgio Doganiero on 11/7/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit

class WelcomeOneViewController: UIViewController {

    @IBOutlet weak var male: UIButton!
    @IBOutlet weak var female: UIButton!
    
    var gToPass: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonSelected(sender: UIButton) {
        
        if sender.tag == 0 {
            gToPass = male.titleLabel?.text
        } else {
            gToPass = female.titleLabel?.text
        }
        
        performSegue(withIdentifier: "SView", sender: self)
    }
    
    @IBAction func unwindToFirstView (segue: UIStoryboardSegue) {
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "SView"{
            
            let nextView = segue.destination as! WelcomeTwoViewController
            nextView.gender = gToPass!
        }
    }

}
