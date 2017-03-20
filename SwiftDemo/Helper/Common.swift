//
//  Common.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/21.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

let Notification_Login = "Pop_Login"

let Notification_Search_Tag = "Search_Tag"

/// 全局背景
let Color_GlobalBackground = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
let Color_GlobalLine = UIColor(red: 237.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
let Color_NavBackground = UIColor(red: 251.0/255.0, green: 45.0/255.0, blue: 71.0/255.0, alpha: 1.0)

let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

//方向
enum TableViewScrollingToDicrection :Int{
    case tableViewScrollingToUp = 0
    case tableViewScrollingToDown = 1
}

