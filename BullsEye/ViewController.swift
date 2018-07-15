//
//  ViewController.swift
//  BullsEye
//
//  Created by Brian Goldfarb on 7/14/18.
//  Copyright © 2018 Brian Goldfarb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue: Int = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var userScore: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var targetValue: Int = 0
    var score = 0 //type inference
    var round = 0

    
    override func viewDidLoad() {
        currentValue = lroundf(slider.value)
        super.viewDidLoad()
         startNewGame()
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        userScore.text = String(score)
        roundLabel.text = String(round)
    }
    
    func startNewRound(){
        round+=1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
   @IBAction func startNewGame(){
        score = 0
        round = 0
        startNewRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
        print("The value of the slider is now: \(slider.value)")
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func showAlert(){
        
        let difference: Int = abs(targetValue - currentValue)
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
             points += 100
        }
        else if difference < 5 {
            if difference == 1 {
                points += 50
            }
            title = "Almost There!"
        }
        else if difference < 10 {
            title = "Not Bad!"
        }
        else{
            title = "Not Close lol"
        }
        
        score += points
        
        let message = "\(points)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome", style: .default, handler: {
            action in
                self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
   


}

