//
//  UILabel+Additions.swift
//  HowNowSchool
//
//  Created by Hitender kumar on 09/03/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

import UIKit

extension UILabel {
    
   func addShadowWith(shadowOffset : CGSize, shadowOpacity : Float, shadowRadius : CGFloat) {
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
    }
}

extension UIButton {
    
   func addShadowWith(shadowOffset : CGSize, shadowOpacity : Float, shadowRadius : CGFloat) {
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
    }
}

extension UIImageView {
    
   func addShadowWith(shadowOffset : CGSize, shadowOpacity : Float, shadowRadius : CGFloat) {
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
    }
}


