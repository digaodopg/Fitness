//
//  WelcomeTwoViewController.swift
//  FitnessApp
//
//  Created by Giorgio Doganiero on 11/7/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit

class WelcomeTwoViewController: UIViewController {

    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    
    var gender: String!
    
    var hToPass: String!
    var wToPass: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.hideKeyboardOnGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonSelected() {
        
        if height.text == "" {
            hToPass = "0"
        } else {
            hToPass = height.text!
        }
        
        if weight.text == "" {
            wToPass = "0"
        } else {
            wToPass = weight.text!
        }
        
        performSegue(withIdentifier: "TView", sender: self)
    }
    
    @IBAction func unwindToSecondView(segue: UIStoryboardSegue) {
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "TView"{
            
            let nextView = segue.destination as! WelcomeThreeViewController
            nextView.gender = self.gender!
            nextView.height = hToPass!
            nextView.weight = wToPass!
            
        }
        
    }

}
