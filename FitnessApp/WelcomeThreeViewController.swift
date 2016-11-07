//
//  WelcomeThreeViewController.swift
//  FitnessApp
//
//  Created by Giorgio Doganiero on 11/7/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class WelcomeThreeViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    
    var gender: String!
    var height: String!
    var weight: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //print("gender: \(gender), height: \(height), weight: \(weight)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed() {
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        var ref = FIRDatabaseReference()
        ref = FIRDatabase.database().reference().child("users").child(uid!)
        
        //ref.updateChildValues(["gender": gender!, "height": height!, "weight": weight!])
        
        performSegue(withIdentifier: "MainView", sender: self)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
