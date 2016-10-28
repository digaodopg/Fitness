//
//  ExercisesTableViewController.swift
//  FitnessApp
//
//  Created by Giorgio Doganiero on 9/19/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit

class ExercisesCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var addButton: UIBarButtonItem!
    var backButton: UIBarButtonItem!
    
    var passedValue: String!
    var valueToPass: String!
    
    var monday = ["Flat DB Press", "Incline DB Press", "JM Press"]
    var tuesday = ["Hammer Curl", "Preacher Hammer Dumbbell Curl", "Incline Barbell Triceps Extension", "Kneeling Cable Triceps Extension"]
    var wednesday = ["Leverage Shoulder Press", "Low Pulley Row To Neck", "Lying One-Arm Lateral Raise", "Machine Shoulder Press"]
    var thrusday = ["Mixed Grip Chin", "One-Arm Dumbbell Row", "One-Arm Kettlebell Row", "Barbell Deadlift"]
    var friday = ["Leg Press", "Leverage Deadlift", "Narrow Stance Squats", "One Leg Barbell Squat"]
    var saturday = ["free day"]
    var sunday = ["free day"]
    var imageMon = [UIImage(named: "1_1"), UIImage(named: "2_1"), UIImage(named: "3_1")]
    var imageTue = [UIImage(named: "4_1"), UIImage(named: "5_1"), UIImage(named: "6_1"), UIImage(named: "7_1")]
    var imageWed = [UIImage(named: "8_1"), UIImage(named: "9_1"), UIImage(named: "10_1"), UIImage(named: "11_1")]
    var imageThr = [UIImage(named: "12_1"), UIImage(named: "13_1"), UIImage(named: "14_1"), UIImage(named: "15_1")]
    var imageFri = [UIImage(named: "16_1"), UIImage(named: "17_1"), UIImage(named: "18_1"), UIImage(named: "19_1")]

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //hide tab bar
        //tabBarController?.tabBar.isHidden = true
        //hide back button
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        //title
        let titleButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width.truncatingRemainder(dividingBy: 2), height: view.frame.height))
        titleButton.setTitle("START", for: UIControlState())
        titleButton.setTitleColor(mainColor(), for: UIControlState())
        titleButton.titleLabel?.font = UIFont(name: "Oswald-Bold", size: 25.0)
        titleButton.addTarget(self, action: #selector(WorkoutViewController.titlePressed(_:)), for: UIControlEvents.touchUpInside)
        self.navigationItem.titleView = titleButton
        
        //edit button
        //addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ViewController.newCell))
        //addButton.tintColor = mainColor()
        //navigationItem.rightBarButtonItem = addButton
        
        //back button
        backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(ExercisesCollectionViewController.goToPreviousView))
        backButton.tintColor = mainColor()
        navigationItem.leftBarButtonItem = backButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func titlePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "SegueShow", sender: self)
        //passpictures
    }
    
    func editExercises() {
    }
    
    func goToPreviousView() {
        _ = navigationController?.popViewController(animated: true)
        //unhide tab bar
        tabBarController?.tabBar.isHidden = false
    }
    
    func exercisesArray() -> [String]{
        switch passedValue {
        case "Chest":
            return monday
        case "Biceps & Triceps":
            return tuesday
        case "Shoulders":
            return wednesday
        case "Back":
            return thrusday
        case "Legs":
            return friday
        default:
            return []
        }
    }
    
    func imagesArray() -> [UIImage]{
        switch passedValue {
        case "Chest":
            return imageMon as! [UIImage]
        case "Biceps & Triceps":
            return imageTue as! [UIImage]
        case "Shoulders":
            return imageWed as! [UIImage]
        case "Back":
            return imageThr as! [UIImage]
        case "Legs":
            return imageFri as! [UIImage]
        default:
            return []
        }
    }
    
    // MARK: - Table view data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.exercisesArray().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.imageView?.image = imagesArray()[indexPath.row]
        cell.titleLabel?.text = exercisesArray()[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "exerciseInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "exerciseInfo"{
        
            let indexPaths = self.collectionView!.indexPathsForSelectedItems!
            let indexPath = indexPaths[0] as NSIndexPath
            
            let vc = segue.destination as! ExerciseInfoViewController
            
            vc.image = imagesArray()[indexPath.row]
            vc.text = exercisesArray()[indexPath.row]
            
            vc.passedValue = exercisesArray()[indexPath.row]
        } else if segue.identifier == "SegueShow" {
            
            let vc = segue.destination as! WorkoutViewController
            
            vc.exerciseCount = exercisesArray().count
            vc.image = imagesArray()
            vc.exerciseType = passedValue
        }
    }
}
