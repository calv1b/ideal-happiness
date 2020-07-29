//
//  NetworkingHandler.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

class Networking {

    static let sharedInstance = Networking()
  
  func getRandomCategory(completion: @escaping (_ categoryID: Int) -> ()) {
      let url: URL = URL(string: "http://www.jservice.io/api/random")!

      URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error { print(error) }
        guard let data = data else { return }
        do {
          let info = try JSONDecoder().decode([Clue].self, from: data)

          completion(info[0].category.id)
          
        } catch let error {
          print(error)
        }
    }.resume()
  }
  
  
  func getAllCluesInCategory(categoryID: Int, completion: @escaping (_ clues: [Clue] ) -> ()) {
  
    let url = URL(string: "http://www.jservice.io/api/clues/?category=\(categoryID)")!
//    print(url)
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let error = error { print(error) }
      guard let data = data else { return }
      do {
        let info = try JSONDecoder().decode([Clue].self, from: data)
        let infoSlice = info[..<4]
        let cluesArray = Array(infoSlice)
        completion(cluesArray)
      } catch let error {
        print(error)
      }
      
    }.resume()
  }
}
