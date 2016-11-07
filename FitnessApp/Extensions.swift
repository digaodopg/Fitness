//
//  Extensions.swift
//  FitnessApp
//
//  Created by Giorgio Doganiero on 9/2/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static func customGreen() -> UIColor {
        return UIColor(red: 187/255, green: 247/255, blue: 55/255, alpha: 1)
    }
    static func customDarkGreen() -> UIColor {
        return UIColor(red: 151/255, green: 224/255, blue: 19/255, alpha: 1)
    }
    static func customBlue() -> UIColor {
        return UIColor(red: 41/255, green: 222/255, blue: 209/255, alpha: 1)
    }
    static func customDarkBlue() -> UIColor {
        return UIColor(red: 1/255, green: 212/255, blue: 197/255, alpha: 1)
    }
    static func customRed() -> UIColor {
        return UIColor(red: 241/255, green: 70/255, blue: 61/255, alpha: 1)
    }
    static func customDarkRed() -> UIColor {
        return UIColor(red: 217/255, green: 30/255, blue: 20/255, alpha: 1)
    }
    static func customGray() -> UIColor {
        return UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1)
    }
    static func customDarkGray() -> UIColor {
        return UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
    }
    static func customLightGray() -> UIColor {
        //return UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)
        return UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
    }
}
extension UIViewController {
    func hideKeyboardOnGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        swipe.direction = .down
        view.addGestureRecognizer(swipe)
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    func mainColor() -> UIColor {
        return UIColor.customGreen()
    }
    func secondaryColor() -> UIColor {
        return UIColor.customDarkGray()
    }
//    func addSwipe() {
//        let directions: [UISwipeGestureRecognizerDirection] = [.Right, .Left]
//        for direction in directions {
//            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(UserDataViewController.handleSwipe(_:)))
//            gesture.direction = direction
//            self.view.addGestureRecognizer(gesture)
//        }
//    }
}

extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case hasRoutine
        case routineList
    }
    
    func setWorkoutList(state: Bool) {
        set(state, forKey: UserDefaultsKeys.hasRoutine.rawValue)
        synchronize()
    }
    
    func getWorkoutList() -> Bool {
        return bool(forKey: UserDefaultsKeys.hasRoutine.rawValue)
    }
    
    func setCustomRoutineList(value: [String]) {
        set(value, forKey: UserDefaultsKeys.routineList.rawValue)
        synchronize()
    }
    
    func getCustomRoutineList() -> [String] {
        return array(forKey: UserDefaultsKeys.routineList.rawValue) as! [String]
    }
    
}

extension ExerciseInfoViewController {
    func exerciseSelected() {
        switch passedValue {
        case "Flat DB Press":
            self.rightImage.image = UIImage(named: "1_2")
            self.mainMuscle.text = "Chest"
            self.guide.text = "Lie down on a flat bench with a dumbbell in each hand resting on top of your thighs. The palms of your hands will be facing each other. Then, using your thighs to help raise the dumbbells up, lift the dumbbells one at a time so that you can hold them in front of you at shoulder width. Once at shoulder width, rotate your wrists forward so that the palms of your hands are facing away from you. The dumbbells should be just to the sides of your chest, with your upper arm and forearm creating a 90 degree angle. Be sure to maintain full control of the dumbbells at all times. This will be your starting position. Then, as you breathe out, use your chest to push the dumbbells up. Lock your arms at the top of the lift and squeeze your chest, hold for a second and then begin coming down slowly. Tip: Ideally, lowering the weight should take about twice as long as raising it. Repeat the movement for the prescribed amount of repetitions of your training program."
            break
        case "Incline DB Press":
            self.rightImage.image = UIImage(named: "2_2")
            self.mainMuscle.text = "Chest"
            self.guide.text = "Lie back on an incline bench with a dumbbell on each hand on top of your thighs. The palms of your hand will be facing each other. By using your thighs to help you get the dumbbells up, clean the dumbbells one arm at a time so that you can hold them at shoulder width. Once at shoulder width, keep the palms of your hands with a neutral grip (palms facing each other). Keep your elbows flared out with the upper arms in line with the shoulders (perpendicular to the torso) and the elbows bent creating a 90-degree angle between the upper arm and the forearm. This will be your starting position. Now bring down the weights slowly to your side as you breathe in. Keep full control of the dumbbells at all times. As you breathe out, push the dumbbells up using your pectoral muscles. Lock your arms in the contracted position, hold for a second and then start coming down slowly. Tip: It should take at least twice as long to go down than to come up. Repeat the movement for the prescribed amount of repetitions. When you are done, place the dumbbells back in your thighs and then on the floor. This is the safest manner to dispose of the dumbbells."
            break
        case "JM Press":
            self.rightImage.image = UIImage(named: "3_2")
            self.mainMuscle.text = "Chest"
            self.guide.text = "Start the exercise the same way you would a close grip bench press. You will lie on a flat bench while holding a barbell at arms length (fully extended) with the elbows in. However, instead of having the arms perpendicular to the torso, make sure the bar is set in a direct line above the upper chest. This will be your starting position. Now beginning from a fully extended position lower the bar down as if performing a lying triceps extension. Inhale as you perform this movement. When you reach the half way point, let the bar roll back about one inch by moving the upper arms towards your legs until they are perpendicular to the torso. Tip: Keep the bend at the elbows constant as you bring the upper arms forward. As you exhale, press the bar back up by using the triceps to perform a close grip bench press. Now go back to the starting position and start over. Repeat for the recommended amount of repetitions."
            break
        case "Hammer Curl":
            self.rightImage.image = UIImage(named: "4_2")
            self.mainMuscle.text = "Biceps"
            self.guide.text = "Stand up with your torso upright and a dumbbell on each hand being held at arms length. The elbows should be close to the torso. The palms of the hands should be facing your torso. This will be your starting position. Now, while holding your upper arm stationary, exhale and curl the weight forward while contracting the biceps. Continue to raise the weight until the biceps are fully contracted and the dumbbell is at shoulder level. Hold the contracted position for a brief moment as you squeeze the biceps. Tip: Focus on keeping the elbow stationary and only moving your forearm. After the brief pause, inhale and slowly begin the lower the dumbbells back down to the starting position. Repeat for the recommended amount of repetitions."
            break
        case "Preacher Hammer Dumbbell Curl":
            self.rightImage.image = UIImage(named: "5_2")
            self.mainMuscle.text = "Biceps"
            self.guide.text = "Place the upper part of both arms on top of the preacher bench as you hold a dumbbell in each hand with the palms facing each other (neutral grip). As you breathe in, slowly lower the dumbbells until your upper arm is extended and the biceps is fully stretched. As you exhale, use the biceps to curl the weight up until your biceps is fully contracted and the dumbbells are at shoulder height. Squeeze the biceps hard for a second at the contracted position and repeat for the recommended amount of repetitions."
            break
        case "Incline Barbell Triceps Extension":
            self.rightImage.image = UIImage(named: "6_2")
            self.mainMuscle.text = "Triceps"
            self.guide.text = "Hold a barbell with an overhand grip (palms down) that is a little closer together than shoulder width. Lie back on an incline bench set at any angle between 45-75-degrees. Bring the bar overhead with your arms extended and elbows in. The arms should be in line with the torso above the head. This will be your starting position. Now lower the bar in a semicircular motion behind your head until your forearms touch your biceps. Inhale as you perform this movement. Tip: Keep your upper arms stationary and close to your head at all times. Only the forearms should move. Return to the starting position as you breathe out and you contract the triceps. Hold the contraction for a second. Repeat for the recommended amount of repetitions."
            break
        case "Kneeling Cable Triceps Extension":
            self.rightImage.image = UIImage(named: "7_2")
            self.mainMuscle.text = "Triceps"
            self.guide.text = "Place a bench sideways in front of a high pulley machine. Hold a straight bar attachment above your head with your hands about 6 inches apart with your palms facing down. Face away from the machine and kneel. Place your head and the back of your upper arms on the bench. Your elbows should be bent with the forearms pointing towards the high pulley. This will be your starting position. While keeping your upper arms close to your head at all times with the elbows in, press the bar out in a semicircular motion until the elbows are locked and your arms are parallel to the floor. Contract the triceps hard and keep this position for a second. Exhale as you perform this movement. Slowly return to the starting position as you breathe in. Repeat for the recommended amount of repetitions."
            break
        case "Leverage Shoulder Press":
            self.rightImage.image = UIImage(named: "8_2")
            self.mainMuscle.text = "Shoulders"
            self.guide.text = "Load an appropriate weight onto the pins and adjust the seat for your height. The handles should be near the top of the shoulders at the beginning of the motion. Your chest and head should be up and handles held with a pronated grip. This will be your starting position. Press the handles upward by extending through the elbow. After a brief pause at the top, return the weight to just above the start position, keeping tension on the muscles by not returning the weight to the stops until the set is complete."
            break
        case "Low Pulley Row To Neck":
            self.rightImage.image = UIImage(named: "9_2")
            self.mainMuscle.text = "Shoulders"
            self.guide.text = "Sit on a low pulley row machine with a rope attachment. Grab the ends of the rope using a palms-down grip and sit with your back straight and your knees slightly bent. Tip: Keep your back almost completely vertical and your arms fully extended in front of you. This will be your starting position. While keeping your torso stationary, lift your elbows and start bending them as you pull the rope towards your neck while exhaling. Throughout the movement your upper arms should remain parallel to the floor. Tip: Continue this motion until your hands are almost next to your ears (the forearms will not be parallel to the floor at the end of the movement as they will be angled a bit upwards) and your elbows are out away from your sides. After holding for a second or so at the contracted position, come back slowly to the starting position as you inhale. Tip: Again, during no part of the movement should the torso move. Repeat for the recommended amount of repetitions."
            break
        case "Lying One-Arm Lateral Raise":
            self.rightImage.image = UIImage(named: "10_2")
            self.mainMuscle.text = "Shoulders"
            self.guide.text = "While holding a dumbbell in one hand, lay with your chest down on a flat bench. The other hand can be used to hold to the leg of the bench for stability. Position the palm of the hand that is holding the dumbbell in a neutral manner (palms facing your torso) as you keep the arm extended with the elbow slightly bent. This will be your starting position. Now raise the arm with the dumbbell to the side until your elbow is at shoulder height and your arm is roughly parallel to the floor as you exhale. Tip: Maintain your arm perpendicular to the torso while keeping your arm extended throughout the movement. Also, keep the contraction at the top for a second. Slowly lower the dumbbell to the starting position as you inhale. Repeat for the recommended amount of repetitions."
            break
        case "Machine Shoulder Press":
            self.rightImage.image = UIImage(named: "11_2")
            self.mainMuscle.text = "Shoulders"
            self.guide.text = "Sit down on the Shoulder Press Machine and select the weight. Grab the handles to your sides as you keep the elbows bent and in line with your torso. This will be your starting position. Now lift the handles as you exhale and you extend the arms fully. At the top of the position make sure that you hold the contraction for a second. Lower the handles slowly back to the starting position as you inhale.Repeat for the recommended amount of repetitions."
            break
        case "Mixed Grip Chin":
            self.rightImage.image = UIImage(named: "12_2")
            self.mainMuscle.text = "Back"
            self.guide.text = "Using a spacing that is just about 1 inch wider than shoulder width, grab a pull-up bar with the palms of one hand facing forward and the palms of the other hand facing towards you. This will be your starting position. Now start to pull yourself up as you exhale. Tip: With the arm that has the palms facing up concentrate on using the back muscles in order to perform the movement. The elbow of that arm should remain close to the torso. With the other arm that has the palms facing forward, the elbows will be away but in line with the torso. You will concentrate on using the lats to pull your body up. After a second contraction at the top, start to slowly come down as you inhale. Repeat for the recommended amount of repetitions. On the following set, switch grips; so if you had the right hand with the palms facing you and the left one with the palms facing forward, on the next set you will have the palms facing forward for the right hand and facing you for the left."
            break
        case "One-Arm Dumbbell Row":
            self.rightImage.image = UIImage(named: "13_2")
            self.mainMuscle.text = "Back"
            self.guide.text = "Choose a flat bench and place a dumbbell on each side of it. Place the right leg on top of the end of the bench, bend your torso forward from the waist until your upper body is parallel to the floor, and place your right hand on the other end of the bench for support. Use the left hand to pick up the dumbbell on the floor and hold the weight while keeping your lower back straight. The palm of the hand should be facing your torso. This will be your starting position. Pull the resistance straight up to the side of your chest, keeping your upper arm close to your side and keeping the torso stationary. Breathe out as you perform this step. Tip: Concentrate on squeezing the back muscles once you reach the full contracted position. Also, make sure that the force is performed with the back muscles and not the arms. Finally, the upper torso should remain stationary and only the arms should move. The forearms should do no other work except for holding the dumbbell; therefore do not try to pull the dumbbell up using the forearms. Lower the resistance straight down to the starting position. Breathe in as you perform this step. Repeat the movement for the specified amount of repetitions. Switch sides and repeat again with the other arm."
            break
        case "One-Arm Kettlebell Row":
            self.rightImage.image = UIImage(named: "14_2")
            self.mainMuscle.text = "Back"
            self.guide.text = "Place a kettlebell in front of your feet. Bend your knees slightly and then push your butt out as much as possible as you bend over to get in the starting position. Grab the kettlebell and pull it to your stomach, retracting your shoulder blade and flexing the elbow. Keep your back straight. Lower and repeat."
            break
        case "Barbell Deadlift":
            self.rightImage.image = UIImage(named: "15_2")
            self.mainMuscle.text = "Back"
            self.guide.text = "Grasp a bar using an overhand grip (palms facing down). You may need some wrist wraps if using a significant amount of weight. Stand with your torso straight and your legs spaced using a shoulder width or narrower stance. The knees should be slightly bent. This is your starting position. Keeping the knees stationary, lower the barbell to over the top of your feet by bending at the hips while keeping your back straight. Keep moving forward as if you were going to pick something from the floor until you feel a stretch on the hamstrings. Inhale as you perform this movement. Start bringing your torso up straight again by extending your hips until you are back at the starting position. Exhale as you perform this movement. Repeat for the recommended amount of repetitions."
            break
        case "Leg Press":
            self.rightImage.image = UIImage(named: "16_2")
            self.mainMuscle.text = "Quadriceps"
            self.guide.text = "Using a leg press machine, sit down on the machine and place your legs on the platform directly in front of you at a medium (shoulder width) foot stance. (Note: For the purposes of this discussion we will use the medium stance described above which targets overall development; however you can choose any of the three stances described in the foot positioning section). Lower the safety bars holding the weighted platform in place and press the platform all the way up until your legs are fully extended in front of you. Tip: Make sure that you do not lock your knees. Your torso and the legs should make a perfect 90-degree angle. This will be your starting position. As you inhale, slowly lower the platform until your upper and lower legs make a 90-degree angle. Pushing mainly with the heels of your feet and using the quadriceps go back to the starting position as you exhale. Repeat for the recommended amount of repetitions and ensure to lock the safety pins properly once you are done. You do not want that platform falling on you fully loaded."
            break
        case "Leverage Deadlift":
            self.rightImage.image = UIImage(named: "17_2")
            self.mainMuscle.text = "Quadriceps"
            self.guide.text = "Load the pins to an appropriate weight. Position yourself directly between the handles. Grasp the bottom handles with a comfortable grip, and then lower your hips as you take a breath. Look forward with your head and keep your chest up. This will be your starting position. Return the weight to the starting position."
            break
        case "Narrow Stance Squats":
            self.rightImage.image = UIImage(named: "18_2")
            self.mainMuscle.text = "Quadriceps"
            self.guide.text = "This exercise is best performed inside a squat rack for safety purposes. To begin, first set the bar on a rack that best matches your height. Once the correct height is chosen and the bar is loaded, step under the bar and place the back of your shoulders (slightly below the neck) across it. Hold on to the bar using both arms at each side and lift it off the rack by first pushing with your legs and at the same time straightening your torso. Step away from the rack and position your legs using a less-than-shoulder-width narrow stance with the toes slightly pointed out. Feet should be around 3-6 inches apart. Keep your head up at all times (looking down will get you off balance) and maintain a straight back. This will be your starting position. (Note: For the purposes of this discussion we will use the medium stance described above which targets overall development; however you can choose any of the three stances discussed in the foot stances section). Begin to slowly lower the bar by bending the knees as you maintain a straight posture with the head up. Continue down until the angle between the upper leg and the calves becomes slightly less than 90-degrees (which is the point in which the upper legs are below parallel to the floor). Inhale as you perform this portion of the movement. Tip: If you performed the exercise correctly, the front of the knees should make an imaginary straight line with the toes that is perpendicular to the front. If your knees are past that imaginary line (if they are past your toes) then you are placing undue stress on the knee and the exercise has been performed incorrectly. Begin to raise the bar as you exhale by pushing the floor with the heel of your foot mainly as you straighten the legs again and go back to the starting position. Repeat for the recommended amount of repetitions."
            break
        case "One Leg Barbell Squat":
            self.rightImage.image = UIImage(named: "19_2")
            self.mainMuscle.text = "Quadriceps"
            self.guide.text = "Start by standing about 2 to 3 feet in front of a flat bench with your back facing the bench. Have a barbell in front of you on the floor. Tip: Your feet should be shoulder width apart from each other. Bend the knees and use a pronated grip with your hands being wider than shoulder width apart from each other to lift the barbell up until you can rest it on your chest. Then lift the barbell over your head and rest it on the base of your neck. Move one foot back so that your toe is resting on the flat bench. Your other foot should be stationary in front of you. Keep your head up at all times as looking down will get you off balance and also maintain a straight back. Tip: Make sure your back is straight and chest is out while performing this exercise. As you inhale, slowly lower your leg until your thigh is parallel to the floor. At this point, your knee should be over your toes. Your chest should be directly above the middle of your thigh. Leading with the chest and hips and contracting the quadriceps, elevate your leg back to the starting position as you exhale. Repeat for the recommended amount of repetitions. Switch legs and repeat the movement."
            break
        default:
            break
        }
    }
}
