//
//  StoryboardInstantiation.swift
//  Travel-IT
//
//  Created by Ankit Singh on 25/05/18.
//  Copyright © 2018 Ankit Singh. All rights reserved.
//

import UIKit

enum AppStoryboard : String{
    case  SB_Main = "Main"
    case  SB_HotPosts = "HotPosts"
    case  SB_Tools  = "Tools"
    case  SB_UserProfile = "UserProfile"
    case  SB_SteemGuide = "SteemGuide"
}

class StoryboardInstantiation: NSObject {
    
    class func storyboardWithType(appStoryboard:AppStoryboard) -> UIStoryboard {
        var storyboard:UIStoryboard? = nil
        
        switch appStoryboard {
        case .SB_Main:
            let infoDict:NSDictionary = NSDictionary.init(dictionary: Bundle.main.infoDictionary!)
            let mainStoryboardName:NSString? = infoDict.object(forKey:"UIMainStoryboardFile") as? NSString
            if (mainStoryboardName == nil) {
                NSException(name:NSExceptionName(rawValue: "Couldn't find Main storyboard file."), reason:nil, userInfo:nil).raise()
            }
            storyboard = UIStoryboard.init(name: mainStoryboardName! as String, bundle: nil)
            break
        case .SB_HotPosts:
            storyboard = UIStoryboard.init(name:AppStoryboard.SB_HotPosts.rawValue, bundle: nil)
            break
        case .SB_Tools:
            storyboard = UIStoryboard.init(name:AppStoryboard.SB_Tools.rawValue, bundle: nil)
            break
        case .SB_UserProfile:
            storyboard = UIStoryboard.init(name:AppStoryboard.SB_UserProfile.rawValue, bundle: nil)
            break
        case .SB_SteemGuide:
            storyboard = UIStoryboard.init(name:AppStoryboard.SB_SteemGuide.rawValue, bundle: nil)
            break
        default:
            NSException(name:NSExceptionName(rawValue: "Couldn't find requested Storyboard file."), reason:nil, userInfo:nil).raise()
            break
        }
        return storyboard!
    }
}

extension UIViewController{
    class func instantiateWithStoryboard(appStoryboard:AppStoryboard) -> UIViewController {
        
        let storyboard:UIStoryboard = StoryboardInstantiation.storyboardWithType(appStoryboard: appStoryboard)
        let viewControllerName:String = "\(self)"
        return storyboard.instantiateViewController(withIdentifier: viewControllerName);
        
    }
}
