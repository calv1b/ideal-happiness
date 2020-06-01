//
//  WikiViewController.swift
//  RGBColorPicker
//
//  Created by Calvin on 5/30/20.
//  Copyright © 2020 Calvin. All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: UIViewController {
    
    @IBOutlet weak var WikiView: WKWebView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let htmlPath = Bundle.main.path(forResource: "RGBwiki", ofType: "html") {
            let url = URL(fileURLWithPath: htmlPath)
            let request = URLRequest(url: url)
            WikiView.load(request)
        }
    }
    
    @IBAction func close() {
        dismiss(animated: true)
           }
    
}
