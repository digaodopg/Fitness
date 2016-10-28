//
//  ViewController.swift
//  FitnessApp
//
//  Created by Giorgio Doganiero on 9/2/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let header = TableViewHeader()
    let tableView = UITableView()
    let userProfile = UIButton(type: .custom)
    @IBOutlet weak var workoutRoutine: UIButton!
    var editButton = UIBarButtonItem()
    
    var days = ["M", "T", "W", "T", "F", "S", "S"]
    var items = ["Chest", "Biceps & Triceps", "Shoulders", "Back", "Legs", "Rest Day", "Rest Day"]
    var workoutList = false
    var currentDay = 0
    var valueToPass: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userProfile.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        userProfile.layer.cornerRadius = 0.5 * userProfile.bounds.size.width
        userProfile.titleLabel?.textAlignment = .center
        userProfile.titleLabel?.font = UIFont(name: "Oswald-Bold", size: 14.0)
        userProfile.setTitleColor(mainColor(), for: UIControlState())
        userProfile.backgroundColor = UIColor.darkGray
        userProfile.addTarget(self, action: #selector(ViewController.profileButtonReleased(_:)), for: .touchUpInside)
        userProfile.addTarget(self, action: #selector(ViewController.profileButtonDrag(_:)), for: .touchDragExit)
        userProfile.addTarget(self, action: #selector(ViewController.profileButtonPressed(_:)), for: .touchDown)
        
        let logout = UIBarButtonItem(customView: userProfile)
        //logout.customView = button
        self.navigationItem.setLeftBarButton(logout, animated: true)
        
        //new cell button
        //let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ViewController.newCell))
        //addButton.tintColor = mainColor()
        //navigationItem.rightBarButtonItem = addButton
        
        
        editButton = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(ViewController.editScheduleAction))
        editButton.tintColor = mainColor()
        navigationItem.rightBarButtonItem = editButton
        
        //nav bar tittle
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width.truncatingRemainder(dividingBy: 2), height: view.frame.height))
        titleLabel.text = "APP NAME"
        titleLabel.textColor = mainColor()
        titleLabel.font = UIFont(name: "Oswald-Bold", size: 25.0)
        self.navigationItem.titleView = titleLabel
        
        //createRoutineButton.backgroundColor = secondaryColor()
        //createRoutineButton.tintColor = mainColor()
        
        //header.editButton.addTarget(header.editButton, action: #selector(ViewController.editScheduleAction), for: .touchUpInside)
        //header.editButton.setTitle("Cool", for: .normal)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkIfUserIsLoggedIn()
        //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //self.button.setTitle(, forState: .Normal)
        
        // load workoutlist from user database
        
        if UserDefaults.standard.object(forKey: UserDefaults.UserDefaultsKeys.hasRoutine.rawValue) != nil {
            if UserDefaults.standard.object(forKey: UserDefaults.UserDefaultsKeys.routineList.rawValue) != nil {
                let customList = UserDefaults.standard.getCustomRoutineList()
                items = customList
            }
            workoutRoutineSelected()
        } else {
            editButton.isEnabled = false
            tableView.removeFromSuperview()
        }
    }
    
    @IBAction func unwindToRootView(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func workoutRoutineSelected() {

        editButton.isEnabled = true
        
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 75
        tableView.separatorStyle = .none
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cellId")
        tableView.register(TableViewHeader.self, forHeaderFooterViewReuseIdentifier: "headerId")
        tableView.sectionHeaderHeight = 40
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.isScrollEnabled = false
        
        workoutList = true
        UserDefaults.standard.setWorkoutList(state: true)
        self.view.addSubview(tableView)
    }
    
    func editScheduleAction() {
        //print("Cool")
        if tableView.isEditing == false {
            self.tableView.setEditing(true, animated: true)
            self.editButton.title = "Done"
        } else if tableView.isEditing == true {
            UserDefaults.standard.setCustomRoutineList(value: items)
            self.tableView.setEditing(false, animated: true)
            self.editButton.title = "Edit"
        }
    }
    
    func checkIfUserIsLoggedIn(){
        if FIRAuth.auth()?.currentUser?.uid == nil
        {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        else
        {
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject]{
                    
                    let firstname = dictionary["firstname"] as? String
                    let lastname = dictionary["lastname"] as? String
                    let nameArray = [firstname, lastname]
                    var initialsArray = [Character]()
                    for string in nameArray {
                        initialsArray.append(string!.characters.first!)
                    }
                    var initials = String()
                    for char in initialsArray {
                        initials.append(char)
                    }
                    
                    self.userProfile.setTitle(initials.uppercased(), for: UIControlState())
                }
                
                
                }, withCancel: nil)
        }
    }
    
    func handleLogout() {
        
        if FIRAuth.auth()?.currentUser == nil {
            
            let loginController = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LogInViewController
            self.present(loginController, animated: true, completion: nil)
        }
    }
    
    @IBAction func profileButtonReleased(_ sender: UIButton) {
        self.userProfile.backgroundColor = UIColor.darkGray
        performSegue(withIdentifier: "ShowProfile", sender: self)
    }
    
    @IBAction func profileButtonPressed(_ sender: UIButton) {
        self.userProfile.backgroundColor = UIColor.gray
    }
    
    @IBAction func profileButtonDrag(_ sender: UIButton) {
        self.userProfile.backgroundColor = UIColor.darkGray
    }
    
    @IBAction func createCustomRoutine(_ sender: UIButton) {
        //self.performSegue(withIdentifier: "SegueShow", sender: self)
        //createRoutineButton.isHidden = true
        //tableRoutine.isHidden = false
    }
    
    func getCellDay(_ index: Int) -> Int {
        let now = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let today = dateFormatter.string(from: now as Date)
        currentDay = Int(today)!
        var day = Int(today)!
        day += index
        return day
    }
    
    func newCell() {
        let maxDays = 7
        
        if maxDays > items.count {
            //items.append("Workout Day \(items.count + 1)")
            //let insertionIndexPath = IndexPath(row: items.count - 1, section: 0)
            //tableView.insertRows(at: [insertionIndexPath], with: .automatic)
        }
    }
    
    // 1 ---- number of items in tableviewcontroller
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // 2 ---- add cells in tableviewcontroller
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CustomCell
        
        cell.cellTitleLabel.text = items[indexPath.row]
        cell.dayLabel.text = days[indexPath.row]
        cell.dateLabel.text  = "\(getCellDay(indexPath.row))"
        
        //if indexPath.row <= 7 {
            //let backgroundView = UIView()
            //backgroundView.backgroundColor = mainColor()
            //cell.selectedBackgroundView = backgroundView
        //}
        
        return cell
    }
    
    // 3 ---- add header to tableviewcontroller
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId")
    }
    
    // 4 ---- tell the tableviewcontroller that cells are editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 5 ---- delete button to cells in tableviewcontroller
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            self.items.remove(at: indexPath.row)
            let nextIndex = IndexPath(row: indexPath.row + 1, section: 0)
            tableView.cellForRow(at: nextIndex)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    // 6 ---- if tableview is in editing mode disable swipe to delete
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    // 7 ---- tell the tableviewcontroller that cells can be moved
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 8 ---- moves the cell to another position in the tableviewcontroller
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let itemToMove = items[sourceIndexPath.row]
        items.remove(at: sourceIndexPath.row)
        items.insert(itemToMove, at: destinationIndexPath.row)
        
        tableView.reloadData()
    }
    
    // 9 ---- perform action when cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let selectedCell: UITableViewCell = tableView.cellForRow(at: indexPath)!
        //selectedCell.contentView.backgroundColor = mainColor()
        if items[indexPath.row] != "Rest Day" && isEditing == false{
            valueToPass = items[indexPath.row] //indexPath.row
            performSegue(withIdentifier: "ShowExercises", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowExercises" {
            let vc = segue.destination as! ExercisesCollectionViewController
            vc.passedValue = self.valueToPass
        }
    }
}
