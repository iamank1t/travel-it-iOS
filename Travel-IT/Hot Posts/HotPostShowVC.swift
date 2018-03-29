//
//  HotPostShowVC.swift
//  Travel-IT
//
//  Created by Ankit Singh on 23/03/18.
//  Copyright © 2018 Ankit Singh. All rights reserved.
//

import UIKit

class HotPostShowVC: UIViewController {
        var postData = [String:AnyObject]()
        var postMainImage: String?
        @IBOutlet var postMainImageView: UIImageView!
        @IBOutlet var postBodyLabel: UILabel!
        override func viewDidLoad() {
            super.viewDidLoad()
            self.postBodyLabel.numberOfLines = 0
            self.populatePostData()
            // Do any additional setup after loading the view.
        }
        
        func populatePostData() {
            if let url = URL(string: postMainImage!) {
                self.postMainImageView.sd_setImage(with: url)
            }
            let postBody = postData["body"]! as! String
            self.postBodyLabel.text = postBody.html2String
            self.fetchUrls(bodyData: postBody.html2String)
        }
        
        func fetchUrls(bodyData: String) {
            let input = bodyData
            let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            let matches = detector.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
            
            for match in matches {
                guard let range = Range(match.range, in: input) else { continue }
                let url = input[range]
                print(url)
            }
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    }
