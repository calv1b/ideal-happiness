//
//  ViewController.swift
//  RGBColorPicker
//
//  Created by Calvin on 5/30/20.
//  Copyright © 2020 Calvin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentRValue = 0
    var currentGValue = 0
    var currentBValue = 0



    
    @IBOutlet weak var redValue: UILabel!
    @IBOutlet weak var greenValue: UILabel!
    @IBOutlet weak var blueValue: UILabel!
    @IBOutlet weak var colorTitle: UILabel!
    @IBOutlet weak var slider1: UISlider!
    @IBOutlet weak var slider2: UISlider!
    @IBOutlet weak var slider3: UISlider!

 
    
    override func viewDidLoad() {
        super.viewDidLoad()

                
    }

    @IBAction func showAlert() {
        
        let alert = UIAlertController(title: "Name a Color", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Color"
        }
        
        
        let action = UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            self.colorTitle.text = textField?.text
            self.view.backgroundColor = UIColor(red: CGFloat(self.currentRValue)/255, green: CGFloat(self.currentGValue)/255, blue: CGFloat(self.currentBValue)/255, alpha: 1)
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
                
        
    }
    
    @IBAction func redSlider(_ slider: UISlider) {
            let roundedValue = slider.value.rounded()
            currentRValue = Int(roundedValue)
            redValue.text = String(currentRValue)

        }
    
    @IBAction func greenSlider(_ slider: UISlider) {
            let roundedValue = slider.value.rounded()
            currentGValue = Int(roundedValue)
            greenValue.text = String(currentGValue)

          }
    
    @IBAction func blueSlider(_ slider: UISlider) {
            let roundedValue = slider.value.rounded()
            currentBValue = Int(roundedValue)
            blueValue.text = String(currentBValue)

          }
    
    

    @IBAction func reset() {
         
        currentRValue = 0
        currentGValue = 0
        currentBValue = 0
        redValue.text = "0"
        greenValue.text = "0"
        blueValue.text = "0"
        slider1.value = Float(currentRValue)
        slider2.value = Float(currentGValue)
        slider3.value = Float(currentBValue)
        colorTitle.text = "Color"
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
        
}
