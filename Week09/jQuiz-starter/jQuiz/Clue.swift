//
//  QuestionCodable.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

struct Clue: Decodable {
  let id: Int
  let answer, question: String
  let value: Int?
  let category: Category

}

struct Category: Decodable {
  let id: Int
  let title: String
  let cluesCount: Int
  
  enum CodingKeys: String, CodingKey {
      case id, title
      case cluesCount = "clues_count"
    }
}
