//
//  ViewController.swift
//  CompatibilitySlider-Start
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var compatibilityItemLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var questionLabel: UILabel!

    var compatibilityItems = ["Cats", "Dogs", "Hiking", "Skiing", "Partying", "Games"] // Add more!
    var currentItemIndex = 0

    var person1 = Person(id: 1, items: [:])
    var person2 = Person(id: 2, items: [:])
    var currentPerson: Person?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        compatibilityItemLabel.text = compatibilityItems[currentItemIndex]
        currentPerson = person1
        questionLabel.text = "Person 1, how do you feel about..."


    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        print(sender.value)
        
    }

    @IBAction func didPressNextItemButton(_ sender: Any) {
                
       playerRound()

    }
    
      @IBAction func showAlert() {
        
        let message = "You two are \(calculateCompatibility()) compatible!"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
          action in
            
            self.reset()


            
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }




    func calculateCompatibility() -> String {
        // If diff 0.0 is 100% and 5.0 is 0%, calculate match percentage
        var percentagesForAllItems: [Double] = []

        for (key, person1Rating) in person1.items {
            let person2Rating = person2.items[key] ?? 0
            let difference = abs(person1Rating - person2Rating)/5.0
            percentagesForAllItems.append(Double(difference))
        }

        let sumOfAllPercentages = percentagesForAllItems.reduce(0, +)
        let matchPercentage = sumOfAllPercentages/Double(compatibilityItems.count)
        print(matchPercentage, "%")
        let matchString = 100 - (matchPercentage * 100).rounded()
        return "\(matchString)%"
    }
    
    func playerRound() {
        
        
        if currentItemIndex < compatibilityItems.count && currentPerson == person1 {
        
                               
            let currentItem = compatibilityItems[currentItemIndex]
            currentPerson?.items.updateValue(slider.value, forKey: currentItem)
            
            currentItemIndex += 1

        
                   
            if currentItemIndex < compatibilityItems.count {
                compatibilityItemLabel.text = compatibilityItems[currentItemIndex]
                    
                }

                   
            if currentItemIndex == compatibilityItems.count {
                currentPerson = person2
                currentItemIndex = 0
                questionLabel.text = "Person 2, how do you feel about..."

                }
                   
        }


        if currentItemIndex <= compatibilityItems.count && currentPerson == person2 {
            
            let tempIndex = currentItemIndex - 1

            
            if currentItemIndex < compatibilityItems.count {
                        compatibilityItemLabel.text = compatibilityItems[currentItemIndex]
                        
                     }
            
            if tempIndex < 0 {
                let currentItem = compatibilityItems[currentItemIndex]
                currentPerson?.items.updateValue(slider.value, forKey: currentItem)
            } else{
                let currentItem = compatibilityItems[tempIndex]
                currentPerson?.items.updateValue(slider.value, forKey: currentItem)
            }
            
            currentItemIndex += 1
            

                   if currentItemIndex - 1 == compatibilityItems.count {
                       showAlert()
                   }
               }

    }
    
    func reset() {
        currentItemIndex = 0
        currentPerson = person1
        compatibilityItemLabel.text = compatibilityItems[currentItemIndex]
        questionLabel.text = "Person 1, how do you feel about..."
        slider.value = 2.5
    }
}




