//
//  PPBaseViewController.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/22.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

class PPBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PPBaseViewController.login), name: Notification_Login, object: nil)
    }
  
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: Notification_Login, object: nil)
    }
    
    @objc private func login(){
     let xib = UIStoryboard(name: "LoginViewController", bundle: nil)
     let login = xib.instantiateInitialViewController()!
        presentViewController(login, animated: true, completion: nil)
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
