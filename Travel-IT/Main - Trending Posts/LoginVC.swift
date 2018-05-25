//
//  LoginVC.swift
//  Travel-IT
//
//  Created by Ankit Singh on 25/05/18.
//  Copyright © 2018 Ankit Singh. All rights reserved.
//

import UIKit
import WebKit
import NVActivityIndicatorView

protocol WKDelegateController:WKScriptMessageHandler {
    
}

class LoginVC: UIViewController, WKUIDelegate, WKNavigationDelegate {
    private var activityView: NVActivityIndicatorView!
   @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var cancelBtn: UIButton!
    
    deinit {
        self.removeWKWebViewCookies()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.title = localizedString(key: "Login", comment: "")
        self.setUpWebView()
        self.setUpCloseItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Interface Builder Actions
    
    @IBAction func cancelBtnAction(_ sender : UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Helpers
    
    func setUpWebView() {
        let configuration = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        configuration.userContentController = userContentController
        self.showLoadingIndicator()
        webview?.load(URLRequest.init(url: URL.init(string: get_login_url)!))
        webview?.uiDelegate = self;
        webview?.navigationDelegate = self
    }
    
    func setUpCloseItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "login_close"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(navigateUserInsideApp))
    }
    
    //MARK: - WKNavigationDelegate
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.stopLoadingIndicator()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.stopLoadingIndicator()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("RequestUrl ========"+(navigationAction.request.url?.absoluteString)!)
        
        decisionHandler(WKNavigationActionPolicy.allow)
        //        decisionHandler(WKNavigationActionPolicy.cancel)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("ResponseUrl ========"+(navigationResponse.response.url?.absoluteString)!)
        
        
        if (navigationResponse.response.url?.absoluteString.contains("access_token"))! {
            DataManager.sharedInstance.saveUserInfo(fromStr: (navigationResponse.response.url?.absoluteString)!)
            decisionHandler(WKNavigationResponsePolicy.cancel);
            self.navigateUserInsideApp()
        }else{
            
            decisionHandler(WKNavigationResponsePolicy.allow);
        }
    }
    
    @IBAction func loginViaSteemConnectPressed(_ sender: Any) {
        
    }
    
    
    //MARK: - ItemOnClick
    @objc func navigateUserInsideApp() {
        let applicationDelegate = UIApplication.shared.delegate as! AppDelegate
        applicationDelegate.navigateUserInsideApp()
    }
    
    //cookie
    func removeWKWebViewCookies(){
        
        //iOS9.0
        if #available(iOS 9.0, *) {
            let dataStore = WKWebsiteDataStore.default()
            dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), completionHandler: { (records) in
                for record in records{
                    //cookie
                    //                    if record.displayName.contains("steemconnect.com"){//cookie
                    WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {
                        //
                        print("\(record)")
                    })
                    //                    }
                }
            })
        } else {
            //ios8.0
            let libraryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
            let cookiesPath = libraryPath! + "/Cookies"
            try!FileManager.default.removeItem(atPath: cookiesPath)
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
