//
//  UILabel+Additions.swift
//  Travel-IT
//
//  Created by Ankit Singh on 25/05/18.
//  Copyright © 2018 Ankit Singh. All rights reserved.
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
