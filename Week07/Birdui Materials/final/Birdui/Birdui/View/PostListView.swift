//
//  PostListView.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct PostListView: View {
  
  @ObservedObject var postView = PostViewModel.init()
  let image = Image("mascot_swift-badge")
  
  var body: some View {
      VStack(alignment: .leading) {
        HeaderView(
          postHandler: postView)
        List {
          ForEach(postView.posts.indices) { index in
            PostView(post: self.postView.posts[index])
          }
        }
      }
    }
  }


struct PostListView_Previews: PreviewProvider {
  static var previews: some View {
    PostListView()
  }
}
