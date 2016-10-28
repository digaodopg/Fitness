//
//  ResetPasswordViewController.swift
//  FitnessApp
//
//  Created by Giorgio Doganiero on 9/9/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage.image = UIImage(named: "BG_02")
        container.backgroundColor = UIColor.customGray().withAlphaComponent(0.8)
        
        emailField.layer.borderWidth = 3.5
        emailField.layer.borderColor = UIColor.customDarkGray().cgColor
        emailField.backgroundColor = UIColor.customLightGray()
        
        resetPasswordButton.backgroundColor = mainColor()
        resetPasswordButton.layer.borderWidth = 1
        resetPasswordButton.layer.cornerRadius = 5
        resetPasswordButton.layer.borderColor = mainColor().cgColor
        resetPasswordButton.setTitleColor(secondaryColor(), for: UIControlState())
        resetPasswordButton.addTarget(self, action: #selector(ResetPasswordViewController.resetPassword), for: .touchUpInside)
        
        cancelButton.backgroundColor = UIColor.customRed()
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.cornerRadius = 5
        cancelButton.layer.borderColor = UIColor.customRed().cgColor
        cancelButton.setTitleColor(secondaryColor(), for: UIControlState())
        cancelButton.addTarget(self, action: #selector(ResetPasswordViewController.cancelResetPassword(_:)), for: .touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //action when return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField{
            //should perform login when return key is pressed
            resetPassword()
            emailField.resignFirstResponder()
        }
        return true
    }
    
    func resetPassword() {
        FIRAuth.auth()?.sendPasswordReset(withEmail: emailField.text!, completion: {
            (error) in
            if error == nil {
                let alertController = UIAlertController(title: "Success", message: "An email with information on how to reset your password has been sent.", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
            
            self.emailField.text = ""
        })
    }
    
    @IBAction func cancelResetPassword(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
