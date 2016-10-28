//
//  SettingsTableViewController.swift
//  FitnessApp
//
//  Created by Giorgio Doganiero on 10/26/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var deleteAccountButton: UIButton!
    @IBOutlet weak var deleteWorkoutRoutine: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if UserDefaults.standard.object(forKey: UserDefaults.UserDefaultsKeys.hasRoutine.rawValue) == nil {
            deleteWorkoutRoutine.setTitleColor(UIColor.customLightGray(), for: UIControlState())
            deleteWorkoutRoutine.isEnabled = false
        } else {
            deleteWorkoutRoutine.setTitleColor(UIColor.black, for: UIControlState())
            deleteWorkoutRoutine.isEnabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func deleteWorkoutRoutinePressed() {
        if UserDefaults.standard.object(forKey: UserDefaults.UserDefaultsKeys.hasRoutine.rawValue) != nil {
            UserDefaults.standard.removeObject(forKey: UserDefaults.UserDefaultsKeys.hasRoutine.rawValue)
            
            if UserDefaults.standard.object(forKey: UserDefaults.UserDefaultsKeys.routineList.rawValue) != nil {
                UserDefaults.standard.removeObject(forKey: UserDefaults.UserDefaultsKeys.routineList.rawValue)
            }
        }
    }
    
    @IBAction func handleUserState(sender: UIButton) {
        if sender.tag == 0 {
            
            handleLogout()
        } else {
            deleteAccount()
        }
    }
    
    func handleLogout() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LogInViewController
        self.present(loginController, animated: true, completion: nil)
    }
    
    func deleteAccount() {
        
        let user = FIRAuth.auth()?.currentUser
        user?.delete(completion: {
            (error) in
            
            if let error = error {
                print("error while deleting account \(error.localizedDescription)")
            } else {
                self.handleLogout()
                self.deleteUserDefaults()
                print("Account deleted")
            }
        })
    }
    
    func deleteUserDefaults() {
        
        if let bundle = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundle)
        }
    }
    
    // MARK: - Table view data source

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
