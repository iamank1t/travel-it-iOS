//
//  CurrentVotingPowerCalculatorVC.swift
//  Travel-IT
//
//  Created by Ankit Singh on 05/05/18.
//  Copyright © 2018 Ankit Singh. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class CurrentVotingPowerCalculatorVC: UIViewController {
    @IBOutlet var votingPowerLabel: UILabel!
    private var activityView: NVActivityIndicatorView!
    @IBOutlet var accountNameTextfield: UITextField!
    var votingPower: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculateButtonClicked(_ sender: Any) {
        if (self.accountNameTextfield.text?.isEmpty)! {
            let alert = UIAlertController(title: "Alert", message: "Please enter account username", preferredStyle: UIAlertControllerStyle.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        else {
        self.showLoadingIndicator()
        let url = URL(string: "https://steemit.com/@" + accountNameTextfield.text! + ".json")!
        URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if(error != nil){
                print("error")
            }else{
                do{
                    var json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: AnyObject]
                    if let votingPower = json["user"]!["voting_power"] as? Int {
                    self.votingPower = "\(votingPower)"
                    DispatchQueue.main.async(execute: {
                        self.stopLoadingIndicator()
                        self.votingPowerLabel.text = String((self.votingPower?.dropLast(2))!) + "%"
                    })
                    } else {
                        DispatchQueue.main.async(execute: {
                        self.stopLoadingIndicator()
                        let alert = UIAlertController(title: "Alert", message: "Please enter valid account username", preferredStyle: UIAlertControllerStyle.alert)
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                        })
                    }
                }catch let error as NSError{
                    print(error)
                }
            }
        }).resume()
        }
    }
    
    func showLoadingIndicator(){
        if activityView == nil{
            activityView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50.0, height: 50.0), type: NVActivityIndicatorType.ballClipRotatePulse, color: UIColor.loaderColor, padding: 0.0)
            activityView.backgroundColor = UIColor.white
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
