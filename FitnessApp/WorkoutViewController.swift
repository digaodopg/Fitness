//
//  WorkoutViewController.swift
//  Fitness
//
//  Created by Giorgio Doganiero on 8/11/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController, CustomClockViewDelegate, PickerViewDelegate, iCarouselDelegate, iCarouselDataSource {
    
    let clockView = CustomClockView()
    let pickerView = PickerViewContainer()
    
    let bound: CGRect = UIScreen.main.bounds
    let startButton = UIButton()
    var editButton = UIBarButtonItem()
    @IBOutlet weak var nextButton: UIButton!

    var exerciseCount: Int!
    var exerciseType: String!
    var image = [UIImage]()
    var buttonEnable = true
    var timer = 3
    
    @IBOutlet weak var exerciseList: iCarousel!
    var exercises = [Int]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        exercises = [1,2,3,4,5,6,7,8,9,10]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //hide tab bar
        tabBarController?.tabBar.isHidden = true
        //hide back button
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        //nav bar tittle button
        let titleButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width.truncatingRemainder(dividingBy: 2), height: view.frame.height))
        titleButton.setTitle("QUIT", for: UIControlState())
        titleButton.setTitleColor(mainColor(), for: UIControlState())
        titleButton.titleLabel?.font = UIFont(name: "Oswald-Bold", size: 25.0)
        titleButton.addTarget(self, action: #selector(WorkoutViewController.titlePressed(_:)), for: UIControlEvents.touchUpInside)
        self.navigationItem.titleView = titleButton
        
        //start button
        startButton.frame = CGRect(x: (view.frame.width / 2) - 150, y: (view.frame.height / 2) - 190, width: 300, height: 300)
        startButton.clipsToBounds = true
        startButton.layer.cornerRadius = 0.5 * startButton.bounds.size.width
        startButton.setTitle("Start", for: UIControlState())
        startButton.titleLabel?.font = UIFont(name: "Oswald-Bold", size: 40)
        startButton.setTitleColor(UIColor.darkGray, for: UIControlState())
        startButton.backgroundColor = UIColor.customGreen()
        startButton.addTarget(self, action: #selector(WorkoutViewController.startButtonReleased(_:)), for: [UIControlEvents.touchUpInside, UIControlEvents.touchUpOutside])
        startButton.addTarget(self, action: #selector(WorkoutViewController.startButtonPressed(_:)), for: UIControlEvents.touchDown)
        self.view.addSubview(startButton)
        
        //next exercise button
        setbuttonEnable(false)
        nextButton.isHidden = true
        nextButton.clipsToBounds = true
        nextButton.setTitle("NEXT EXERCISE", for: UIControlState())
        nextButton.titleLabel?.font = UIFont(name: "Oswald-Bold", size: 25.0)
        nextButton.setTitleColor(mainColor(), for: UIControlState())
        nextButton.backgroundColor = secondaryColor()
        nextButton.addTarget(self, action: #selector(WorkoutViewController.nextButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(nextButton)
        
        //custom clock view
        clockView.backgroundColor = UIColor.clear
        clockView.frame = CGRect(x: (view.frame.width / 2) - 150, y: (view.frame.height / 2) - 190, width: 300, height: 300)
        clockView.layer.zPosition = -1
        
        //clockView.countTimer.invalidate()
        //clockView.resetIntervalTimer()
        clockView.setIntervalTimer(timer)
        clockView.intervalButton.addTarget(self, action: #selector(WorkoutViewController.changeIntervalTime(_:)), for: .touchUpInside)
        
        //custom picker view
        pickerView.clipsToBounds = true
        pickerView.backgroundColor = UIColor.clear
        pickerView.frame = CGRect(x: 0, y: view.frame.height - 50, width: view.frame.width, height: view.frame.height / 2)
        
        //exercises list
        exerciseList.isHidden = false
        exerciseList.backgroundColor = secondaryColor()
        exerciseList.type = .linear
        //exerciseList.indexesForVisibleItems
        exerciseList.contentOffset = CGSize(width: 0,height: 0)
        
        clockView.delegate = self
        pickerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //add time to timer
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return exerciseCount
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        let temp = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        temp.backgroundColor = UIColor.customGreen()
        
        if exerciseType != nil {
            //let images = UIImage(named: "1_1")
            let imageView = UIImageView(image: image[index])
            imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
            temp.addSubview(imageView)
            return temp
        }
        return temp
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.spacing {
            return value * 1.1
        }
        
        return value
    }
    
    @IBAction func titlePressed(_ sender: UIButton) {
        //go to previous vc
        _ = navigationController?.popViewController(animated: true)
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let vc = storyboard.instantiateViewController(withIdentifier: "MainVC")
        //_ = navigationController?.popToViewController(vc, animated: true)
        //unhide tab bar
        //tabBarController?.tabBar.isHidden = false
        exerciseList.isHidden = true
    }
    
    @IBAction func startButtonReleased(_ sender: UIButton) {
        startButton.isHidden = true
        nextButton.isHidden = false
        self.view.addSubview(clockView)
        clockView.intervalButton.isEnabled = true
        clockView.startClockTimer()
        
        setbuttonEnable(true)
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        startButton.backgroundColor = UIColor.customDarkGreen()
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        setbuttonEnable(false)
        clockView.intervalButton.isEnabled = false
        clockView.resetIntervalTimer()
        clockView.startIntervalTimer()
        clockView.pauseButton.isEnabled = false
    }
    
    @IBAction func changeIntervalTime(_ sender: UIButton) {
        sender.setTitleColor(UIColor.black, for: UIControlState())
        setbuttonEnable(false)
        
        self.view.addSubview(pickerView)
        UIView.animate(withDuration: 0.5, animations: {self.pickerView.frame =
            CGRect(x: self.pickerView.frame.origin.x,
                y: self.pickerView.frame.origin.y - self.pickerView.frame.size.height,
                width: self.pickerView.frame.size.width,
                height: self.pickerView.frame.size.height)})
        //change interval label color back to grey when done is pressed
        //picker.hidden = false
    }
    
    //next exercise button
    func setbuttonEnable(_ state: Bool) {
        self.nextButton.isEnabled = state
        clockView.intervalButton.isEnabled = state
    }
    
    func nextExercise() {
        //exerciseList.currentItemIndex += 1
        exerciseList.scrollToItem(at: exerciseList.currentItemIndex + 1, animated: true)
    }
    
    func getButtonEnable() -> Bool {
        return buttonEnable
    }
    
    func intervalButtonPressed(_ color: UIColor) {
        clockView.intervalButton.setTitleColor(color, for: UIControlState())
    }
}
