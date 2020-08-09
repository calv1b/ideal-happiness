//
//  ViewController.swift
//  AnimationHomework
//
//  Created by calvin williams on 8/8/20.
//  Copyright © 2020 calvin williams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var playButton: UIButton!
  @IBOutlet weak var colorButton: UIButton!
  @IBOutlet weak var sizeButton: UIButton!
  @IBOutlet weak var moveButton: UIButton!
  
  @IBOutlet private var colorButtonConstraint: NSLayoutConstraint!
  @IBOutlet private var sizeButtonConstraint: NSLayoutConstraint!
  @IBOutlet private var moveButtonConstraint: NSLayoutConstraint!
  
  @IBOutlet private var moveAnimationObject: NSLayoutConstraint!
  @IBOutlet private var moveAnimationObjectVertical: NSLayoutConstraint!
  
  @IBOutlet private var animationObject: UIImageView!
  
  private var playButtonPressed = false
  private var colorButtonPressed = false
  private var moveButtonPressed = false
  private var sizeButtonPressed = false
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    colorButton.isHidden = true
    sizeButton.isHidden = true
    moveButton.isHidden = true

    

  }
  
  func addAnimation() {
    if !self.playButtonPressed {
      
      UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 5, animations: {
        self.animationObject.backgroundColor = self.colorButtonPressed ? .black : .gray
        self.animationObject.transform = self.sizeButtonPressed ? CGAffineTransform(scaleX: 2, y: 2) : CGAffineTransform(scaleX: 1, y: 1)
          self.moveAnimationObject.constant = self.moveButtonPressed ? 200 : 100
        self.moveAnimationObjectVertical.constant = self.moveButtonPressed ? 200 : 100
        self.view.layoutIfNeeded()
        
      })
    }
  }

}

private extension ViewController {
  

  
  @IBAction func playPressed() {
    
    playButtonPressed.toggle()
    
    colorButton.isHidden = false
    sizeButton.isHidden = false
    moveButton.isHidden = false

    view.layoutIfNeeded()
    
    colorButtonConstraint.constant = playButtonPressed ? -100 : 0
    sizeButtonConstraint.constant = playButtonPressed ? 150 : 95
    moveButtonConstraint.constant = playButtonPressed ? 100 : 0
    self.addAnimation()

    
    UIView.animate(withDuration: 0.25, delay: 0, options: .allowUserInteraction, animations: {
      self.view.layoutIfNeeded()

      
    }, completion: {_ in
      self.colorButton.isHidden = self.playButtonPressed ? false : true
      self.moveButton.isHidden = self.playButtonPressed ? false : true
      self.sizeButton.isHidden = self.playButtonPressed ? false : true

      
    })
  }
  
  @IBAction func colorPressed() {
    colorButtonPressed.toggle()
  }
  
  @IBAction func movePressed() {
    moveButtonPressed.toggle()
  }
  
  @IBAction func sizePressed() {
    sizeButtonPressed.toggle()
  }
}

