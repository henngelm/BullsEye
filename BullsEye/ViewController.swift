//
//  ViewController.swift
//  BullsEye
//
//  Created by Henngel Mojica on 2/2/18.
//  Copyright © 2018 Henngel Mojica. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startNewGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlert() {
        // calculate the difference between the random number and the slider's value.
        let difference = abs(targetValue - currentValue)
        // calculate the points reached in each round
        var points = 100 - difference
        // alert title
        let alertTitle: String
        // alert title message
        if difference == 0 {
            alertTitle = "Perfect!"
            // bonus points
            points += 100
        } else if difference <= 5 {
            alertTitle = "You almost had it!"
            // bonus points
            if difference == 1 {
                points += 50
            }
        } else if difference <= 10 {
            alertTitle = "Pretty good!"
        } else {
            alertTitle = "Not even close!"
        }
        print(difference)
        // update the total score
        score += points
        
        let message = "You scored \(points) points"
//        let message = "The value of the slider is: \(currentValue)" +
//                      "\nThe target value is: \(targetValue)" + "\nThe difference is: \(difference)"
        let alert = UIAlertController(title: alertTitle,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: {
                                    action in self.startNewRound()
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
//        startNewRound()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    @IBAction func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
}

