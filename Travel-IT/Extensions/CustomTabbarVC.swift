//
//  CustomTabbarVC.swift
//  Travel-IT
//
//  Created by Ankit Singh on 22/03/18.
//  Copyright © 2018 Ankit Singh. All rights reserved.
//

import UIKit

class CustomTabbarVC: UITabBarController, UITabBarControllerDelegate {
    
    var previousSelectedIndex : Int?
    var selectedTabUnderline : UIView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.barTintColor = UIColor.loaderColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.delegate = self
        // Do any additional setup after loading the view.
        // Add background color to middle tabBarItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
                let view = item.value(forKey: "view") as! UIView
                let icon = view.subviews[0] as! UIImageView
                self.bounceAnimation(icon: icon)
    }
    
 // bounce animation code
    func bounceAnimation(icon: UIImageView) {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0 ,1.4, 0.9, 1.0]
        bounceAnimation.duration = 0.4
        bounceAnimation.calculationMode = kCAAnimationCubic
        icon.layer.add(bounceAnimation, forKey: "bounceAnimation")
        
    }
}
