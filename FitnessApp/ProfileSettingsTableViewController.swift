//
//  ProfileSettingsTableViewController.swift
//  FitnessApp
//
//  Created by Giorgio Doganiero on 11/2/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileSettingsTableViewController: UITableViewController {

    @IBOutlet weak var done: UIBarButtonItem!
    @IBOutlet weak var cancel: UIBarButtonItem!
    @IBOutlet weak var userFirstName: UITextField!
    @IBOutlet weak var userLastName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    var firstName = String()
    var lastName = String()
    var email = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if FIRAuth.auth()?.currentUser?.uid != nil {
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject]{
                    
                    self.firstName = (dictionary["firstname"] as? String)!
                    self.lastName = (dictionary["lastname"] as? String)!
                    self.email = (dictionary["email"] as? String)!
                    
                    self.userFirstName.placeholder = self.firstName
                    //self.userFirstName.text = self.firstName
                    self.userLastName.placeholder = self.lastName
                    //self.userLastName.text = self.lastName
                    self.userEmail.placeholder = self.email
                    //self.userEmail.text = self.email
                }
                
            }, withCancel: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveChanges() {
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        var ref = FIRDatabaseReference()
        ref = FIRDatabase.database().reference().child("users").child(uid!)
        
        if userFirstName.text != "" {
            //ref.setValue(["firstname": userFirstName.text])
            ref.updateChildValues(["firstname": userFirstName.text!])
        }
        if userLastName.text != "" {
            //ref.setValue(["lastname": userLastName.text])
            ref.updateChildValues(["lastname": userLastName.text!])
        }
        if userEmail.text != "" {
            let user = FIRAuth.auth()?.currentUser
            
            if user != nil {
                user?.updateEmail(userEmail.text!, completion: { (error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        ref.updateChildValues(["email": self.userEmail.text!])
                        print("email updated successfully")
                    }
                })
            }
        }
        self.performSegue(withIdentifier: "UnwindSave", sender: self)
    }
    
    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
