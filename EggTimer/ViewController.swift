//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var labelTimer: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft": 5, "Medium": 7*60, "Hard": 12*60]
    
    var timer = Timer()
    
    var player: AVAudioPlayer?
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
        guard let hardness = sender.currentTitle else { return }
        
        guard var timeToCook = eggTimes[hardness] else { return }
        
        guard let progressToCook = eggTimes[hardness] else { return }
        
//        Timer countdown
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            timer in
            
            self.progressBar.progress = Float(timeToCook) / Float(progressToCook)
            
            self.labelTimer.text = "\(timeToCook) second"
            timeToCook -= 1
            self.progressBar.progress = Float(timeToCook) / Float(progressToCook)
            
            if timeToCook == 0 {
                self.labelTimer.text = "Done!"
                self.playTimerSound()
                timer.invalidate()
            }
        }
    }
    
    func playTimerSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
        player = try! AVAudioPlayer(contentsOf: url)
        player?.play()
    }
}

//90
