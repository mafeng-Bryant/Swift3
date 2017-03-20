//
//  PPTabBarController.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/22.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

class PPTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
       addChildViewControllers()
        UITabBar.setupStyle()
    }
   
    fileprivate func addChildViewControllers(){
        addChildViewController(HomeViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(HotViewController(), title: "热门", imageName: "tabbar_gift")
        addChildViewController(ClassfiyViewController(), title: "分类", imageName: "tabbar_category")
        addChildViewController(MeViewController(), title: "我", imageName: "tabbar_me")
    }
    
    fileprivate func addChildViewController(_ childController: UIViewController ,title:String,imageName:String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")
        childController.tabBarItem.title = title
        let nav = PPBaseNavigationController()
        nav.addChildViewController(childController)
        addChildViewController(nav)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
