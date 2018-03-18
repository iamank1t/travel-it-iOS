//
//  PostShowVC.swift
//  Travel-IT
//
//  Created by Ankit Singh on 17/03/18.
//  Copyright © 2018 Ankit Singh. All rights reserved.
//

import UIKit

class PostShowVC: UIViewController {
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
