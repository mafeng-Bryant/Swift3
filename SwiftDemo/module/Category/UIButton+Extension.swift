//
//  UIButton+Extension.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/19.
//  Copyright © 2016年 test. All rights reserved.
//

import Foundation

extension UIButton{

    convenience init(x: CGFloat, iconName: NSString, target: AnyObject?, action: Selector, imageEdgeInsets: UIEdgeInsets){
     self.init()
     frame = CGRect(x: x,y: 0,width: 44,height: 44)
     setImage(UIImage(named: iconName as String), forState: UIControlState.Normal)
     setImage(UIImage(named: iconName as String), forState: UIControlState.Highlighted)
     self.imageEdgeInsets = imageEdgeInsets
     addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    /// 导航栏排序按钮
    convenience init(sortTarget: AnyObject?, action: Selector) {
        self.init()
        frame = CGRect(x: 0, y: 0, width: 44.0, height: 44.0)
        contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        setImage(UIImage(named: "icon_sort"), forState: UIControlState.Normal)
        addTarget(sortTarget, action: action, forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    /// 导航栏返回按钮
    convenience init(backTarget: AnyObject?, action: Selector) {
        self.init()
        setImage(UIImage(named: "back"), forState: UIControlState.Normal)
        frame = CGRect(x: 0, y: 0, width: 44.0, height: 44.0)
        contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        addTarget(backTarget, action: action, forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    /// 导航栏取消按钮
    convenience init(cancelTarget: AnyObject?, action: Selector) {
        self.init()
        setTitle("取消", forState: UIControlState.Normal)
        frame = CGRect(x: 0, y: 0, width: 44.0, height: 44.0)
        contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        addTarget(cancelTarget, action: action, forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    
    
    
    
}

