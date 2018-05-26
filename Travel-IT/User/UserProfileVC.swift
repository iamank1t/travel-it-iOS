//
//  UserProfileVC.swift
//  Travel-IT
//
//  Created by Ankit Singh on 23/03/18.
//  Copyright © 2018 Ankit Singh. All rights reserved.
//

import UIKit
import SDWebImage
import NVActivityIndicatorView
import SwiftyJSON

class UserProfileVC: UIViewController {
    private var loaderView: NVActivityIndicatorView!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var logoutButton: UIBarButtonItem!
    let application = UIApplication.shared
    var finalUserData: [String:AnyObject]?
    override func viewDidLoad() {
        self.userName.text = ""
        super.viewDidLoad()
        if let username = UserDefaults.standard.object(forKey: UserDataSaveConstants.st_userName_save) as? String {
            self.navigationItem.title = "User Profile"
            self.userName.text = username
            self.getUserData(userName: username)
        }
        else {
            self.logoutButton.title = "Login"
        }
        // Do any additional setup after loading the view.
    }

    func getUserData(userName: String) {
        self.showLoadingIndicator()
        let url = URL(string: "https://steemit.com/@" + userName + ".json")!
        URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if(error != nil){
                print("error")
            }else{
                do{
                    var json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: AnyObject]
                        if let userDetailData = json["user"]!["json_metadata"] as? [String: AnyObject] {
                            DispatchQueue.main.async {
                                self.finalUserData = userDetailData["profile"] as? [String: AnyObject]
                                if let userImageUrl = self.finalUserData!["profile_image"] as? String {
                                    self.userImage.sd_setImage(with: URL(string: userImageUrl), completed: nil)
                                    self.userImage.sd_setImage(with: URL(string: userImageUrl), placeholderImage: UIImage(named: "defaultImage.png"))
                                }
                                else {
                                    self.userImage.image = #imageLiteral(resourceName: "defaultImage")
                                }
                            self.stopLoadingIndicator()
                            }
                        }
                }catch let error as NSError{
                    print(error)
                }
            }
        }).resume()
    }
    
    @IBAction func logoutLoginButtonClicked(_ sender: Any) {
        if self.logoutButton.title == "Login" {
           self.performSegue(withIdentifier: "loginUser", sender: self)
        }
        else {
            UserDefaults.standard.removeObject(forKey: UserDataSaveConstants.st_access_token_save)
            UserDefaults.standard.removeObject(forKey: UserDataSaveConstants.st_userName_save)
            UserDefaults.standard.removeObject(forKey: UserDataSaveConstants.st_expires_in_save)
            UserDefaults.standard.synchronize()
            let mainVc : MainVC = MainVC.instantiateWithStoryboard(appStoryboard: .SB_Main) as! MainVC
            let tAppdelegate = application.delegate as! AppDelegate
            tAppdelegate.window?.rootViewController = mainVc
        }
    }
    
    
    func showLoadingIndicator(){
        if loaderView == nil{
            loaderView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50.0, height: 50.0), type: NVActivityIndicatorType.lineScalePulseOutRapid, color: UIColor.white, padding: 0.0)
            // add subview
            view.addSubview(loaderView)
            // autoresizing mask
            loaderView.translatesAutoresizingMaskIntoConstraints = false
            // constraints
            view.addConstraint(NSLayoutConstraint(item: loaderView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: loaderView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
        }
        
        loaderView.startAnimating()
    }
    
    func stopLoadingIndicator(){
        loaderView.stopAnimating()
    }
    
    
}
