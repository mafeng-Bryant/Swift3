//
//  NavgationBarExtension.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/20.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
     class func setupStyle(){
        let navBar = UINavigationBar.appearance()
        navBar.tintColor =  UIColor(red: 255.0/255.0, green: 2.0/255.0, blue: 51.0/255, alpha: 1.0)
        navBar.setBackgroundImage(UIImage.imageWithColor(Color_NavBackground, size: CGSizeMake(1, 1)), forBarMetrics: UIBarMetrics.Default)
        navBar.translucent = false
        var textAttrs: [String : AnyObject] = Dictionary()
        textAttrs[NSForegroundColorAttributeName] = UIColor.whiteColor()
        textAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(16)
        navBar.titleTextAttributes = textAttrs
     }
    
}

