//
//  UIButton+Extension.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/19.
//  Copyright © 2016年 test. All rights reserved.
//

import Foundation

extension UIButton{

    convenience init(title: String, titleColor: UIColor = kNormalColor, backColor: UIColor = kWhiteColor){
     self.init()
        setTitle(title, forState: UIControlState.Normal)
       setTitleColor(titleColor, forState: UIControlState.Normal)
        backgroundColor = backColor
    }

    convenience init(backgroundImageName:String){
     self.init()
        setBackgroundImage(UIImage(named: backgroundImageName), forState: UIControlState.Normal)
        setBackgroundImage(UIImage(named: backgroundImageName + "_highlighted"), forState: UIControlState.Highlighted)
        sizeToFit()
    }
    
    
    convenience init(title: String, imageName: String, color: UIColor, fontSize: CGFloat) {
        self.init()
        
        setTitle(title, forState: UIControlState.Normal)
        setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        setTitleColor(color, forState: UIControlState.Normal)
        
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
    }
    
    /// 便利构造函数
    ///
    /// - parameter title:     title
    /// - parameter fontSize:  fontSize
    /// - parameter color:     color
    /// - parameter backColor: backColor 背景颜色
    ///
    /// - returns: UIButton
    convenience init(title: String, fontSize: CGFloat, color: UIColor = UIColor.whiteColor(), backColor: UIColor = UIColor.darkGrayColor()) {
        self.init()
        
        setTitle(title, forState: UIControlState.Normal)
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        
        setTitleColor(color, forState: UIControlState.Normal)
        backgroundColor = backColor
    }
    
    /// 便利构造函数
    ///
    /// - parameter imageName: imageName
    ///
    /// - returns: UIButton
    convenience init(imageName: String) {
        self.init()
        
        setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        
        sizeToFit()
    }
    
    
    convenience init(title: String, backgroudImageName: String, color: UIColor, font: UIFont) {
        self.init()
        
        setTitle(title, forState: UIControlState.Normal)
        setBackgroundImage(UIImage(named: backgroudImageName), forState: UIControlState.Normal)
        setTitleColor(color, forState: UIControlState.Normal)
        
        titleLabel?.font = font
    }
    



}

