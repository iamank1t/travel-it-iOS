//
//  CustomNavigationVC.swift
//  Travel-IT
//
//  Created by Ankit Singh on 22/03/18.
//  Copyright © 2018 Ankit Singh. All rights reserved.
//

import UIKit

class CustomNavigationVC: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backImage = UIImage(named: "Back")
        self.navigationBar.isTranslucent = true
        self.navigationBar.backIndicatorImage = backImage
        self.navigationBar.tintColor = UIColor.black
        self.navigationBar.barTintColor = UIColor.loaderColor
        self.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationBar.topItem?.title = " "
//        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Avenir-Next-Regular", size: 20)!, NSAttributedStringKey.foregroundColor: UIColor.blue]
        self.navigationBar.setTitleVerticalPositionAdjustment(2, for: UIBarMetrics.default)
        // Do any additional setup after loading the view.
    }
    
}
