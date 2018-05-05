//
//  HotPostShowVC.swift
//  Travel-IT
//
//  Created by Ankit Singh on 23/03/18.
//  Copyright © 2018 Ankit Singh. All rights reserved.
//

import UIKit
import Down
import NVActivityIndicatorView

class HotPostShowVC: UIViewController {
        private var activityView: NVActivityIndicatorView!
        var postData = [String:AnyObject]()
        override func viewDidLoad() {
            super.viewDidLoad()
            self.populatePostData()
            // Do any additional setup after loading the view.
        }
        
        func populatePostData() {
            self.showLoadingIndicator()
            let postBody = postData["body"]! as! String
            guard let downView = try? DownView(frame: self.view.bounds, markdownString: postBody, didLoadSuccessfully: {
                self.stopLoadingIndicator()
                print("Markdown was rendered.")
            }) else {
                self.stopLoadingIndicator()
                return }
            view.addSubview(downView)
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    
    func showLoadingIndicator(){
        if activityView == nil{
            activityView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50.0, height: 50.0), type: NVActivityIndicatorType.ballClipRotatePulse, color: UIColor.loaderColor, padding: 0.0)
            // add subview
            view.addSubview(activityView)
            // autoresizing mask
            activityView.translatesAutoresizingMaskIntoConstraints = false
            // constraints
            view.addConstraint(NSLayoutConstraint(item: activityView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: activityView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
        }
        
        activityView.startAnimating()
    }
    
    func stopLoadingIndicator(){
        activityView.stopAnimating()
    }
    }
