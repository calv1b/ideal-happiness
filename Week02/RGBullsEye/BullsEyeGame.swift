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

import Foundation

struct BullsEyeGame {  // might be class?
        
        // var currentValue = 0
    var currentRValue = RGB().r
    var currentGValue = RGB().g
    var currentBValue = RGB().b
    var targetRValue = 0
    var targetGValue = 0
    var targetBValue = 0
    var score = 0
    var round = 0
        
        mutating func startNewRound() {
           round += 1
           targetRValue = Int.random(in: 1...255)
           targetGValue = Int.random(in: 1...255)
           targetBValue = Int.random(in: 1...255)
           currentRValue = 127
           currentGValue = 127
           currentBValue = 127
            
            
        }
        
    }

