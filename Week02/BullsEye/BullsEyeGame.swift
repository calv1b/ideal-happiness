//
//  BullsEyeGame.swift
//  BullsEye
//
//  Created by Calvin on 6/7/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import Foundation

struct BullsEyeGame {
    
    // var currentValue = 0
    var currentRValue = 0
    var currentGValue = 0
    var currentBValue = 0
    var targetRValue = 0
    var targetGValue = 0
    var targetBValue = 0
    var score = 0
    var round = 0
    
    mutating func startNewRound() {
       round += 1
       targetRValue = Int.random(in: 1...100)
       targetGValue = Int.random(in: 1...100)
       targetBValue = Int.random(in: 1...100)
       currentRValue = 50
       currentGValue = 50
       currentBValue = 50
    }
    
}
