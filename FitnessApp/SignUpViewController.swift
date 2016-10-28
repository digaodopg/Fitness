//
//  SignUpViewController.swift
//  FitnessApp
//
//  Created by Giorgio Doganiero on 9/2/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var signUp: UIButton!
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    
    let vc = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImage.image = UIImage(named: "BG_02")
        
        login.layer.borderWidth = 1
        login.layer.cornerRadius = 5
        login.layer.borderColor = mainColor().cgColor
        login.setTitleColor(mainColor(), for: UIControlState())
        login.addTarget(self, action: #selector(SignUpViewController.loginViewController(_:)), for: [.touchUpInside, .touchUpOutside])
        
        logoImage.image = UIImage(named: "Logo")
        logoImage.backgroundColor = UIColor.clear
        
        container.backgroundColor = UIColor.customGray().withAlphaComponent(0.8)
        
        firstName.layer.borderWidth = 3.5
        firstName.layer.borderColor = UIColor.customDarkGray().cgColor
        firstName.backgroundColor = UIColor.customLightGray()
        
        lastName.layer.borderWidth = 3.5
        lastName.layer.borderColor = UIColor.customDarkGray().cgColor
        lastName.backgroundColor = UIColor.customLightGray()
        
        emailField.layer.borderWidth = 3.5
        emailField.layer.borderColor = UIColor.customDarkGray().cgColor
        emailField.backgroundColor = UIColor.customLightGray()
        
        passwordField.layer.borderWidth = 3.5
        passwordField.layer.borderColor = UIColor.customDarkGray().cgColor
        passwordField.backgroundColor = UIColor.customLightGray()
        
        signUp.backgroundColor = mainColor()
        signUp.layer.borderWidth = 1
        signUp.layer.cornerRadius = 5
        signUp.layer.borderColor = mainColor().cgColor
        signUp.setTitleColor(secondaryColor(), for: UIControlState())
        signUp.addTarget(self, action: #selector(SignUpViewController.registrationAction(_:)), for: .touchUpInside)
        
        self.hideKeyboardWhenTapped()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //action when return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstName {
            lastName.becomeFirstResponder()
        } else if textField == lastName {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField{
            //should perform login when return key is pressed
            handleRegistration()
            passwordField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func loginViewController(_ sender: UIButton) {
        if sender.tag == 1 //login button
        {
            self.dismiss(animated: false, completion: nil)
        }
        else if sender.tag == 2 //signup button
        {
            performSegue(withIdentifier: "ShowMainView", sender: self)
        }
    }
    
    //create and store user to firebase db
    fileprivate func handleRegistration() {
        guard let name = firstName.text, let lastName = lastName.text, let email = emailField.text, let password = passwordField.text else {
            let alertController = UIAlertController(title: "Error", message: "Please fill all required fields", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {
            (user, error) in
                    
            if error != nil
            {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
            
                let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                    
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            //stores user info to database
            guard let uid = user?.uid else {
                return
            }
            
            let ref = FIRDatabase.database().reference(fromURL: "https://fitnessapp-42f01.firebaseio.com/")
            let usersReference = ref.child("users").child(uid)
            let values = ["firstname": name, "lastname": lastName, "email": email, "workout list": self.vc.workoutList] as [String : Any]

            usersReference.updateChildValues(values, withCompletionBlock: {
                (err, ref) in
                
                if err != nil
                {
                    print(err)
                }
                else
                {
                    print("User data saved successfully into Firebase")
                }
            })
                
            self.firstName.text = ""
            self.lastName.text = ""
            self.emailField.text = ""
            self.passwordField.text = ""
            self.performSegue(withIdentifier: "SignUpSegue", sender: self)
        })
    }
    
    @IBAction func registrationAction(_ sender: UIButton) {
        handleRegistration()
        //self.performSegueWithIdentifier("UserSetupSegue", sender: self)
        
//        let stb = UIStoryboard(name: "Main", bundle: nil)
//        let wt = stb.instantiateViewControllerWithIdentifier("container") as? BWWalkthroughViewController
//        let first = stb.instantiateViewControllerWithIdentifier("page_1") as UIViewController
//        let second = stb.instantiateViewControllerWithIdentifier("page_2") as UIViewController
//        let third = stb.instantiateViewControllerWithIdentifier("page_3") as UIViewController
//        
//        wt?.delegate = self
//        wt?.addViewController(first)
//        wt?.addViewController(second)
//        wt?.addViewController(third)
//        
//        self.presentViewController(wt!, animated: true, completion: nil)
    }
}
