//
//  ViewController.swift
//  EggTimer
//
//  Created by Harry on 05/11/2020.


import UIKit
// import audio bundle
import AVFoundation

class ViewController: UIViewController {
    
    // dict for egg times
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 700]
    // counter for timer & total time
    var totalTime = 0
    var secondsPassed = 0
    // init for timer
    var timer = Timer()
    // init audio player
    var player: AVAudioPlayer!
    // var for title to change to done when timer is finished
    @IBOutlet weak var titleHeading: UILabel!
    // var for progress bar
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    // function when button is pressed
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        // cancel timer if already running
        // means user clicked on another button
        timer.invalidate()
        
        // set progress bar
        progressBar.progress = 0.0
        
        // set secondsPassed back to 0 if user clicks on another button
        secondsPassed = 0
        
        // the hardness the user selected
        let hardness = sender.currentTitle!
        
        // set label title to hardness of egg
        titleHeading.text = hardness
        
        // Set up timer
        //izziswift.com/how-can-i-make-a-countdown-with-nstimer
        // Solution 2
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        // seconds remaining is the value of element in eggTimes
        totalTime = eggTimes[hardness]!
        
        
    }
    
    // func to update timer
    @objc func updateCounter() {
        if secondsPassed < totalTime {
            // increment
            secondsPassed += 1
            // progress bar needs a float and goes from 0 - 0.99
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            
            
        } else {
            // timer has finished
            // set text of title to done
            timer.invalidate()
            titleHeading.text = "Done !"
            // call play sound function with the title of button
            // pressed
            playSound(soundName: "alarm_sound")
        }
    }
    
    // function that takes string and plays the correct sounds
    // matching the string "soundName"
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    
}
