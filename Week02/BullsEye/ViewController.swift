//
//  ViewController.swift
//  BullsEye
//
//  Created by Ray Wenderlich on 6/13/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  //var currentValue = 0
  //var targetValue = 0
  //var score = 0
  //var round = 0
  var gameModel = BullsEyeGame()

  
  @IBOutlet weak var redSlider: UISlider!
  @IBOutlet weak var greenSlider: UISlider!
  @IBOutlet weak var blueSlider: UISlider!
    
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!
    
    
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let roundedRValue = redSlider.value.rounded()
    let roundedGValue = greenSlider.value.rounded()
    let roundedBValue = blueSlider.value.rounded()
    gameModel.currentRValue = Int(roundedRValue)
    gameModel.currentGValue = Int(roundedGValue)
    gameModel.currentBValue = Int(roundedBValue)
    startNewGame()
  }

  @IBAction func showAlert() {
    
    let difference = abs((gameModel.targetRValue - gameModel.currentRValue) + (gameModel.targetGValue - gameModel.currentGValue) + (gameModel.targetBValue - gameModel.currentBValue))

    var points = 100 - difference
    
    gameModel.score += points
    
    let title: String
    if difference == 0 {
      title = "Perfect!"
      points += 100
    } else if difference < 5 {
      title = "You almost had it!"
      if difference == 1 {
        points += 50
      }
    } else if difference < 10 {
      title = "Pretty good!"
    } else {
      title = "Not even close..."
    }
    
    let message = "You scored \(points) points"
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let action = UIAlertAction(title: "OK", style: .default, handler: {
      action in
        self.gameModel.startNewRound()
        self.redSlider.value = Float(self.gameModel.currentRValue)
        self.greenSlider.value = Float(self.gameModel.currentGValue)
        self.blueSlider.value = Float(self.gameModel.currentBValue)
        self.updateLabels()


        
    })
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
    
  }
  
  @IBAction func sliderMoved(_ slider: UISlider) {
    let roundedRValue = redSlider.value.rounded()
    let roundedGValue = greenSlider.value.rounded()
    let roundedBValue = blueSlider.value.rounded()
    gameModel.currentRValue = Int(roundedRValue)
    gameModel.currentGValue = Int(roundedGValue)
    gameModel.currentBValue = Int(roundedBValue)
  }
  
  /* func startNewRound() {
    round += 1
    targetValue = Int.random(in: 1...100)
    currentValue = 50
    slider.value = Float(currentValue)
    updateLabels()
  } */
  
  func updateLabels() {
    targetLabel.text = String(gameModel.targetRValue)
    scoreLabel.text = String(gameModel.score)
    roundLabel.text = String(gameModel.round)
    redSlider.value = Float(gameModel.currentRValue)
    greenSlider.value = Float(gameModel.currentGValue)
    blueSlider.value = Float(gameModel.currentBValue)

  }
  
  @IBAction func startNewGame() {
    gameModel.score = 0
    gameModel.round = 0
    gameModel.startNewRound()
    updateLabels()
    }
  
}



