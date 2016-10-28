//
//  ExerciseListTableViewController.swift
//  FitnessApp
//
//  Created by Giorgio Doganiero on 10/28/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit

class ExerciseListTableViewController: UITableViewController {
    
    var exercises = ["Flat DB Press", "Incline DB Press", "JM Press", "Hammer Curl", "Preacher Hammer Dumbbell Curl", "Incline Barbell Triceps Extension", "Kneeling Cable Triceps Extension", "Leverage Shoulder Press", "Low Pulley Row To Neck", "Lying One-Arm Lateral Raise", "Machine Shoulder Press", "Mixed Grip Chin", "One-Arm Dumbbell Row", "One-Arm Kettlebell Row", "Barbell Deadlift", "Leg Press", "Leverage Deadlift", "Narrow Stance Squats", "One Leg Barbell Squat"]
    
    var exerciseImages = [UIImage(named: "1_1"), UIImage(named: "2_1"), UIImage(named: "3_1"), UIImage(named: "4_1"), UIImage(named: "5_1"), UIImage(named: "6_1"), UIImage(named: "7_1"), UIImage(named: "8_1"), UIImage(named: "9_1"), UIImage(named: "10_1"), UIImage(named: "11_1"), UIImage(named: "12_1"), UIImage(named: "13_1"), UIImage(named: "14_1"), UIImage(named: "15_1"), UIImage(named: "16_1"), UIImage(named: "17_1"), UIImage(named: "18_1"), UIImage(named: "19_1")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //tabBarController?.tabBar.isHidden = false
        
        //nav bar items
        let tittleButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width.truncatingRemainder(dividingBy: 2), height: view.frame.height))
        tittleButton.setTitle("All", for: UIControlState())
        tittleButton.setTitleColor(UIColor.darkGray, for: UIControlState())
        tittleButton.titleLabel?.font = UIFont(name: "Oswald-Regular", size: 20.0)
        self.navigationItem.titleView = tittleButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return exercises.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomExerciseListCell

        // Configure the cell...
        cell.exerciseName?.text = exercises[indexPath.row]
        cell.exerciseImage?.image = exerciseImages[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "ShowDescription", sender: self)
    }

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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDescription" {
            
            let indexPaths = self.tableView!.indexPathsForSelectedRows!
            let indexPath = indexPaths[0] as NSIndexPath
            
            let vc = segue.destination as! ExerciseInfoViewController
            let images = exerciseImages as! [UIImage]
            
            vc.image = images[indexPath.row]
            vc.text = exercises[indexPath.row]
            vc.passedValue = exercises[indexPath.row]
        }
    }
 

}
