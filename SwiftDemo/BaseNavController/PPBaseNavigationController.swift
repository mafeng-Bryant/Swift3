//
//  PPBaseNavigationController.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/19.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

class PPBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = nil;
        UINavigationBar.setupStyle()
        
    }
    
    lazy var backBtn: UIButton = UIButton(backTarget: self, action: #selector(PPBaseNavigationController.backBtnAction))
    
    func backBtnAction(){
    self.popViewControllerAnimated(true)
    }
     
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count>1 {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView:backBtn)
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
