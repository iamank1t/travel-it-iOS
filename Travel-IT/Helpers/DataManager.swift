//
//  DataManager.swift
//  Travel-IT
//
//  Created by Ankit Singh on 25/05/18.
//  Copyright © 2018 Ankit Singh. All rights reserved.
//

import UIKit

func userDefault() -> UserDefaults{
    return UserDefaults.standard
}

struct UserDataLogin {
    static let st_user_data_login = "st_user_data_login"
    static let st_user_data_logout = "st_user_data_logout"
}

struct UserDataSaveConstants {
    static let st_access_token_save = "st_access_token"
    static let st_userName_save = "st_userName"
    static let st_expires_in_save = "st_expires_in"
}

struct UserDataGetConstants {
    static let st_access_token = "access_token"
    static let st_userName = "username"
    static let st_expires_in = "expires_in"
}

class DataManager: NSObject {
    
    
    static let sharedInstance:DataManager = {
        let instance = DataManager()
        return instance
    }()
    
    func isLogin() -> Bool {
        if userDefault().object(forKey: UserDataSaveConstants.st_access_token_save) != nil {
            return true
        }
        return false
    }
    
    
    func getToken() -> String {
        return userDefault().object(forKey: UserDataSaveConstants.st_access_token_save) as! String
    }
    
   
    func getUserName() -> String {
        return userDefault().object(forKey: UserDataSaveConstants.st_userName_save) as! String
    }
    
   
    func logout() {
        userDefault().removeObject(forKey: UserDataSaveConstants.st_userName_save)
        userDefault().removeObject(forKey: UserDataSaveConstants.st_access_token_save)
        userDefault().removeObject(forKey: UserDataSaveConstants.st_expires_in_save)
        userDefault().synchronize()
        
        NotificationCenter.default.post(name: NSNotification.Name(UserDataLogin.st_user_data_logout), object: nil, userInfo:nil)
    }
    
    
    func saveUserInfo(fromStr:String) {
        
        if  let userName = self.paramValueOfUrl(url: fromStr, param: UserDataGetConstants.st_userName) {
            userDefault().set(userName, forKey: UserDataSaveConstants.st_userName_save)
        }
        
        if  let access_token = self.paramValueOfUrl(url: fromStr, param: UserDataGetConstants.st_access_token) {
            userDefault().set(access_token, forKey: UserDataSaveConstants.st_access_token_save)
        }
        
        if  let expires_in = self.paramValueOfUrl(url: fromStr, param: UserDataGetConstants.st_expires_in) {
            userDefault().set(expires_in, forKey: UserDataSaveConstants.st_expires_in_save)
        }
        userDefault().synchronize()
        
        NotificationCenter.default.post(name: NSNotification.Name(UserDataLogin.st_user_data_login), object: nil, userInfo:nil)
    }
    
    func paramValueOfUrl(url:String,param:String) -> String? {
        
        let regTags = String.init(format: "(^|&|\\?)+%@=+([^&]*)(&|$)", arguments: [param])
        do {
            let regex = try NSRegularExpression.init(pattern: regTags, options: NSRegularExpression.Options.caseInsensitive)
            
            let matches = regex.matches(in: url, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange.init(location: 0, length: url.count))
            print("matches.count" + String.init(format: "%d", matches.count))
            for mactch:NSTextCheckingResult in matches {
                
                let tagValue = (url as NSString).substring(with: mactch.range(at: 2))
                return tagValue
            }
        } catch {}
        
        return nil
    }
}
