//
//  PostView.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct PostView: View {
  
  let post: MediaPost
  static var date: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMM, h:mm a"
    return formatter
  }

  
  
  var body: some View {
    
    
      VStack(alignment: .leading) {
        
        HStack {
          Image("mascot_swift-badge").resizable().frame(width: 50.0, height: 50.0)
          VStack(alignment: .leading) {
            Text(post.userName)
          Text("\(post.timestamp, formatter: PostView.self.date)")
          }
        }
        post.textBody.map({Text( $0 )})
        HStack {
          Spacer()
          post.uiImage.map({Image(uiImage: $0 ).resizable().frame(width: 100.0, height: 100.0)})
          Spacer()
        }
      }
  }
}

struct PostView_Previews: PreviewProvider {
  static var previews: some View {
    PostView(post: MediaPost(textBody: "Went to the Aquarium today :]",
      userName: "Audrey", timestamp: Date(timeIntervalSinceNow: -9876),
      uiImage: UIImage(named: "octopus")))
  }
}



