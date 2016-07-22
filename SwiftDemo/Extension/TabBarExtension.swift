//
//  TabBarExtension.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/20.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit


extension UITabBar {

    class func setupStyle(){
    
        self.appearance().tintColor =  UIColor(red: 255.0/255.0, green: 2.0/255.0, blue: 51.0/255, alpha: 1.0);
        
        let tabbarItem = UITabBarItem.appearance()
        
        let selectedAttr = [
          
            NSForegroundColorAttributeName : UIColor(red: 212 / 255.0, green: 25 / 255.0, blue: 38 / 255.0, alpha: 1.0)
            
        ]
         tabbarItem .setTitleTextAttributes(selectedAttr, forState: .Selected)
        
    }
  
}