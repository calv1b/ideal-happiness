/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class ViewController: UIViewController {
    
    var quickDiff: Int {
        return abs(game.targetBValue - game.currentBValue)
    }
    
 
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var targetTextLabel: UILabel!
  @IBOutlet weak var guessLabel: UILabel!
  
  @IBOutlet weak var redLabel: UILabel!
  @IBOutlet weak var greenLabel: UILabel!
  @IBOutlet weak var blueLabel: UILabel!
  
  @IBOutlet weak var redSlider: UISlider!
  @IBOutlet weak var greenSlider: UISlider!
  @IBOutlet weak var blueSlider: UISlider!
  
  @IBOutlet weak var roundLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  
  var game = BullsEyeGame()
  var rgb = RGB()
   
  
  @IBAction func aSliderMoved(sender: UISlider) {
    let roundedRValue = redSlider.value.rounded()
    let roundedGValue = greenSlider.value.rounded()
    let roundedBValue = blueSlider.value.rounded()
    game.currentRValue = Int(roundedRValue)
    game.currentGValue = Int(roundedGValue)
    game.currentBValue = Int(roundedBValue)
    redLabel.text = String(redSlider.value.rounded())
    greenLabel.text = String(greenSlider.value.rounded())
    blueLabel.text = String(blueSlider.value.rounded())
    blueSlider.minimumTrackTintColor =
    UIColor.blue.withAlphaComponent(CGFloat(quickDiff)/100.0)
    guessLabel.backgroundColor = UIColor(red: CGFloat(redSlider.value.rounded()/255), green: CGFloat(greenSlider.value.rounded()/255), blue: CGFloat(blueSlider.value.rounded()/255), alpha: 1.0)
    
  }
  
    @IBAction func showAlert(Sender: AnyObject) {
    var points = 0
    game.score += points
        let difference = RGB.differenceX(target.r)
    
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
        self.game.startNewRound()
        self.targetLabel.backgroundColor = UIColor(red: CGFloat(self.game.targetRValue)/255, green: CGFloat(self.game.targetGValue)/255, blue: CGFloat(self.game.targetBValue)/255, alpha: 1.0)
        self.redSlider.value = Float(self.game.currentRValue)
        self.greenSlider.value = Float(self.game.currentGValue)
        self.blueSlider.value = Float(self.game.currentBValue)
        self.updateView()
    })
    }
  
  @IBAction func startOver() {
    game.score = 0
    game.round = 0
    game.startNewRound()
    updateView()
    targetLabel.backgroundColor = UIColor(red: CGFloat(game.targetRValue)/255, green: CGFloat(game.targetGValue)/255, blue: CGFloat(game.targetBValue)/255, alpha: 1.0)
  }
  
  func updateView() {
       scoreLabel.text = String(game.score)
       roundLabel.text = String(game.round)
       redSlider.value = Float(game.currentRValue)
       greenSlider.value = Float(game.currentGValue)
       blueSlider.value = Float(game.currentBValue)
       blueSlider.minimumTrackTintColor =
       UIColor.blue.withAlphaComponent(CGFloat(quickDiff)/100.0)
    
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    game.startNewRound()
    let roundedRValue = redSlider.value.rounded()
    let roundedGValue = greenSlider.value.rounded()
    let roundedBValue = blueSlider.value.rounded()
    redLabel.text = String(redSlider.value.rounded())
    greenLabel.text = String(greenSlider.value.rounded())
    blueLabel.text = String(blueSlider.value.rounded())
    game.currentRValue = Int(roundedRValue)
    game.currentGValue = Int(roundedGValue)
    game.currentBValue = Int(roundedBValue)
   // targetLabel.backgroundColor = UIColor(red: CGFloat(game.targetRValue/255), green: CGFloat(game.targetGValue/255), blue: CGFloat(game.targetBValue/255), alpha: 1.0)
    targetLabel.backgroundColor = UIColor(red: CGFloat(game.targetRValue)/255, green: CGFloat(game.targetGValue)/255, blue: CGFloat(game.targetBValue)/255, alpha: 1.0)
    blueSlider.minimumTrackTintColor =
    UIColor.blue.withAlphaComponent(CGFloat(quickDiff)/100.0)
    
    guessLabel.backgroundColor = UIColor(red: CGFloat(redSlider.value.rounded()/255), green: CGFloat(greenSlider.value.rounded()/255), blue: CGFloat(blueSlider.value.rounded()/255), alpha: 1.0)
    
    }
}

