//
//  LogInViewController.swift
//  Fitness
//
//  Created by Giorgio Doganiero on 9/1/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var login: UIButton!
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage.image = UIImage(named: "BG_01")
        
        signUp.layer.borderWidth = 1
        signUp.layer.cornerRadius = 5
        signUp.layer.borderColor = mainColor().cgColor
        signUp.setTitleColor(mainColor(), for: UIControlState())
        signUp.addTarget(self, action: #selector(LogInViewController.signUpViewController(_:)), for: [.touchUpInside, .touchUpOutside])
        
        container.backgroundColor = UIColor.customGray().withAlphaComponent(0.8)
        
        emailField.layer.borderWidth = 3.5
        emailField.layer.borderColor = UIColor.customDarkGray().cgColor
        emailField.backgroundColor = UIColor.customLightGray()
        
        passwordField.layer.borderWidth = 3.5
        passwordField.layer.borderColor = UIColor.customDarkGray().cgColor
        passwordField.backgroundColor = UIColor.customLightGray()
        
        login.backgroundColor = mainColor()
        login.layer.borderWidth = 1
        login.layer.cornerRadius = 5
        login.layer.borderColor = mainColor().cgColor
        login.setTitleColor(secondaryColor(), for: UIControlState())
        login.addTarget(self, action: #selector(LogInViewController.loginAction(_:)), for: .touchUpInside)
        
        self.hideKeyboardWhenTapped()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField{
            //should perform login when return key is pressed
            handleLogin()
            passwordField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func signUpViewController(_ sender: UIButton) {
        textFieldsReset()
        
        let signupController = self.storyboard?.instantiateViewController(withIdentifier: "SignupVC") as! SignUpViewController
        self.present(signupController, animated: false, completion: nil)
    }
    
    func textFieldsReset() {
        self.emailField.text = ""
        self.passwordField.text = ""
    }
    
    //login user to firebase db
    fileprivate func handleLogin() {
        guard let email = emailField.text, let password = passwordField.text else {
            print("textfield not filled")
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        //signin user with email
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: {
            (user, error) in
                
            if error != nil
            {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
            
                let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
                self.present(alertController, animated: true, completion: nil)
                return
            }
        
            //if no error perform segue to main view
            self.textFieldsReset()
            self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
            //self.dismiss(animated: true, completion: nil)
        })
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        handleLogin()
    }
}
