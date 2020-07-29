//
//  ViewController.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var clueLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scoreLabel: UILabel!

    var clues: [Clue] = []
    var correctAnswerClue: String = ""
    var points: Int = 0
    var answerArray: [String] = []

  fileprivate func getClues() {
    Networking.sharedInstance.getRandomCategory { (ID)  in
      Networking.sharedInstance.getAllCluesInCategory(categoryID: ID) { (clues) in
        self.clues = clues
        self.setUpView()
      }
    }
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        getClues()


        self.scoreLabel.text = "\(self.points)"

        if SoundManager.shared.isSoundEnabled == false {
            soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        } else {
            soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
        }

        SoundManager.shared.playSound()
     
    }

    @IBAction func didPressVolumeButton(_ sender: Any) {
        SoundManager.shared.toggleSoundPreference()
        if SoundManager.shared.isSoundEnabled == false {
            soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        } else {
            soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
        }
    }
  
  
  func setUpView() {
    let selectedClue = clues.randomElement()
    let categoryTitle = selectedClue?.category.title
    let question = selectedClue?.question
    let correctAnswer = selectedClue?.answer
    let arrayOfAnswers = clues.compactMap {$0.answer}
    if correctAnswer != nil {
      correctAnswerClue = correctAnswer! } else {
      correctAnswerClue = ""
    }

    
    DispatchQueue.main.async {
      self.categoryLabel.text = categoryTitle
      self.clueLabel.text = question
      self.answerArray = arrayOfAnswers
      self.scoreLabel.text = self.points.description
      self.tableView.reloadData()
    }

  }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return answerArray.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = answerArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      guard let cell = tableView.cellForRow(at: indexPath) else { return }
      if cell.textLabel?.text == correctAnswerClue {
        points += 100
        getClues()
      } else {
        getClues()
        
      }
    }
}

