//
//  ViewController.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    var cells = TableViewCell()
    var media = MediaPostsHandler.shared

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()


    }

    func setUpTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        MediaPostsHandler.shared.getPosts()
        tableView.reloadData()


        
    }

    @IBAction func didPressCreateTextPostButton(_ sender: Any) {
        
        let message = "Make a post!"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
            alert.addTextField { (textField) in
            textField.placeholder = "Username"
            textField.keyboardType = .default
            textField.delegate = self
        }


            alert.addTextField { (textField) in
            textField.placeholder = "Message"
            textField.delegate = self
        }
    

        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
          action in
            let user = alert.textFields![0].text
            let text = alert.textFields![1].text
            let textPost = TextPost(textBody: text, userName: user!, timestamp: Date())
            MediaPostsHandler.shared.addTextPost(textPost: textPost)
            self.tableView.reloadData()

            
            
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }

    @IBAction func didPressCreateImagePostButton(_ sender: Any) {

    }

}

extension ViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MediaPostsHandler.shared.mediaPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let date = DateFormatter()
        date.dateFormat = "d MMM, h:mm a"
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath)

            if let post = MediaPostsHandler.shared.mediaPosts[indexPath.row] as? ImagePost {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for:  indexPath)
                let imageCell = cell as! ImageTableViewCell
                imageCell.bodyLabel.text = post.textBody
                imageCell.nameLabel.text = post.userName
                imageCell.dateLabel.text = date.string(from: post.timestamp)
                imageCell.imageLabel.image = post.image
                tableView.rowHeight = 250
                return imageCell
        }
                
            if let post = MediaPostsHandler.shared.mediaPosts[indexPath.row] as? TextPost {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath)
                let textCell = cell as! TableViewCell
                textCell.nameLabel.text = post.userName
                textCell.dateLabel.text = date.string(from: post.timestamp)
                textCell.bodyLabel.text = post.textBody
                tableView.rowHeight = 150
                return textCell
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    
}



