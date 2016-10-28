//
//  CustomClockView.swift
//  Fitness
//
//  Created by Giorgio Doganiero on 8/10/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

protocol CustomClockViewDelegate : class {
    func setbuttonEnable(_ state: Bool)
    func nextExercise()
}

class CustomClockView: UIView {
    
    weak var delegate: CustomClockViewDelegate?
    var shapeLayer = CAShapeLayer()
    var pathLayer = CAShapeLayer()
    var countTimer = Timer()
    var countDownTimer = Timer()
    var stoptimer = Date()
    var timerLabel = UILabel()
    var intervalButton = UIButton()
    var pauseButton = UIButton()
    var doneButton = UIButton()
    var timerValue = 0
    var intervalValue = 0
    var originalValue = 0
    var fillAnimationDuration = 0.7
    var isPaused = false
    var enable = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.createLabel()
        self.customButtons()
        self.drawCircle()
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
        //fatalError("This class does not support NSCoding")
    }
    
    func drawCircle() {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 150, y: 150), radius: CGFloat(150), startAngle: CGFloat(-M_PI_2), endAngle: CGFloat(2*M_PI-M_PI_2), clockwise: true)
        
        self.shapeLayer.path = circlePath.cgPath
        self.shapeLayer.fillColor = UIColor.clear.cgColor
        self.shapeLayer.strokeColor = UIColor.customGreen().cgColor
        self.shapeLayer.lineWidth = 9
        self.shapeLayer.lineCap = kCALineCapRound
        self.shapeLayer.lineJoin = kCALineJoinRound
        self.shapeLayer.zPosition = 1
        
        let ringPath = UIBezierPath(arcCenter: CGPoint(x: 150, y: 150), radius: CGFloat(150), startAngle: CGFloat(-M_PI_2), endAngle: CGFloat(2*M_PI-M_PI_2), clockwise: true)
        
        self.pathLayer.path = ringPath.cgPath
        self.pathLayer.fillColor = UIColor.clear.cgColor
        self.pathLayer.strokeColor = UIColor.customLightGray().cgColor
        self.pathLayer.lineWidth = 2
        self.pathLayer.lineCap = kCALineCapRound
        //self.pathLayer.
        
        self.layer.addSublayer(self.shapeLayer)
        self.layer.addSublayer(self.pathLayer)
    }
    
    func createLabel() {
        self.timerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        self.timerLabel.textAlignment = .center
        self.timerLabel.font = UIFont(name: "Oswald-Light", size: 50)
        self.timerLabel.textColor = UIColor.customDarkGray()
        self.timerLabel.layer.zPosition = 0
        self.addSubview(self.timerLabel)
        
        self.intervalButton = UIButton(frame: CGRect(x: 0, y: 150 + 50, width: 300, height: 25))
        self.intervalButton.contentHorizontalAlignment = .center
        self.intervalButton.titleLabel!.font = UIFont(name: "Oswald-ExtraLight", size: 25)
        self.intervalButton.setTitleColor(UIColor.customLightGray(), for: UIControlState())
        self.intervalButton.layer.zPosition = 1
        self.addSubview(self.intervalButton)
    }
    
    func customButtons() {
        self.pauseButton = UIButton(frame: CGRect(x: 260, y: 250, width: 50, height: 50))
        self.pauseButton.layer.cornerRadius = 0.5 * self.pauseButton.bounds.size.width
        self.pauseButton.contentHorizontalAlignment = .center
        self.pauseButton.setTitle("p", for: UIControlState())
        self.pauseButton.setTitleColor(UIColor.darkGray, for: UIControlState())
        self.pauseButton.backgroundColor = UIColor.customGreen()
        self.pauseButton.layer.zPosition = 2
        self.pauseButton.addTarget(self, action: #selector(CustomClockView.pauseButtonReleased(_:)), for: [.touchUpInside, .touchUpOutside])
        self.pauseButton.addTarget(self, action: #selector(CustomClockView.pauseButtonPressed(_:)), for: .touchDown)
        self.addSubview(pauseButton)
        
        self.doneButton = UIButton(frame: CGRect(x: -10, y: 250, width: 50, height: 50))
        self.doneButton.layer.cornerRadius = 0.5 * self.doneButton.bounds.size.width
        self.doneButton.contentHorizontalAlignment = .center
        self.doneButton.setTitle("d", for: UIControlState())
        self.doneButton.setTitleColor(UIColor.darkGray, for: UIControlState())
        self.doneButton.backgroundColor = UIColor.customGreen()
        self.doneButton.layer.zPosition = 2
        self.addSubview(doneButton)
    }
    
    @IBAction func pauseButtonReleased(_ sender: UIButton) {
        self.pauseButton.backgroundColor = UIColor.customGreen()
        if isPaused {
            self.shapeLayer.strokeColor = UIColor.customGreen().cgColor
            startClockTimer()
            isPaused = false
        } else {
            self.shapeLayer.strokeColor = UIColor.customRed().cgColor
            self.countTimer.invalidate()
            //enable = false next exercise button
            isPaused = true
        }
    }
    
    @IBAction func pauseButtonPressed(_ sender: UIButton) {
        self.pauseButton.backgroundColor = UIColor.customDarkGreen()
    }
    
    func emptyAnimation() {
        self.shapeLayer.strokeColor = UIColor.customRed().cgColor
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = Double(self.intervalValue)
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        self.shapeLayer.add(animation, forKey: "ani")
    }
    
    func fillAnimation() {
        self.shapeLayer.strokeColor = UIColor.customGreen().cgColor
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = Double(self.fillAnimationDuration)
        animation.fillMode = kCAFillModeBackwards
        animation.isRemovedOnCompletion = false
        
        self.shapeLayer.add(animation, forKey: "ani")
    }
    
    func updateTimerLabel(_ value: Int) {
        self.setTimerLabelText(self.timerFormat(value))
    }
    
    func updateIntervalLabel(_ value: Int) {
        self.setIntervalLabelText(self.intervalFormat(value))
    }
    
    func setTimerLabelText(_ value: String) {
        self.timerLabel.text = value
    }
    
    func setIntervalLabelText(_ value: String) {
        //self.intervalButton.text = value
        self.intervalButton.setTitle("\(value)", for: UIControlState())
    }
    
    func timerFormat(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds/60) % 60
        let hours: Int = totalSeconds / 3600
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func intervalFormat(_ totalSeconds: Int) -> String {
        let seconds = totalSeconds % 60
        let minutes = (totalSeconds/60) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @objc func counter(_ dt: Timer) {
        self.timerValue += 1
        //this should go when the pause button is pressed
        //self.countTimer.invalidate()
        self.updateTimerLabel(self.timerValue)
    }
    
    //interval countdown
    @objc func countdown(_ dt: Timer) {
        self.intervalValue -= 1
        //if countdown reaches 0
        if self.intervalValue <= 0 {
            //AudioServicesPlaySystemSound(SystemSoundID(1304))
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            self.fillAnimation()
            self.resetIntervalTimer()
            self.updateIntervalLabel(self.intervalValue)
            //set next button enable to true
            delegate?.setbuttonEnable(true)
            delegate?.nextExercise()
            pauseButton.isEnabled = true
            intervalButton.isEnabled = true
            self.countDownTimer.invalidate()
        }
        else {
            self.updateIntervalLabel(self.intervalValue)
        }
    }
    
    func startTimer() {
        self.updateTimerLabel(timerValue)
    }
    
    func setIntervalTimer(_ value: Int) {
        self.originalValue = value
        self.intervalValue = value
        self.updateIntervalLabel(value)
    }
    
    func resetIntervalTimer() {
        //restore original interval value and update label
        self.intervalValue = self.originalValue
        //self.updateIntervalLabel(self.intervalValue)
    }
    
    func startClockTimer() {
        self.countTimer = Timer .scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(CustomClockView.counter(_:)), userInfo: nil, repeats: true)
        startTimer()
    }
    
    func startIntervalTimer() {
        self.countDownTimer = Timer .scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(CustomClockView.countdown(_:)), userInfo: nil, repeats: true)
        emptyAnimation()
    }
}
