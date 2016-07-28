//
//  PPSearchViewController.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/28.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

private let searchCellIdentifier = "searchGiftCell"

class PPSearchViewController: PPBaseViewController {

    private var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupUI()
         addNotification()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotification()
    }
   
    private func setupUI(){
    
        
    
    }
    
    private lazy var searchBar:UISearchBar = UISearchBar(searchGifdelegate: self, backgroundColor: UIColor.whiteColor(), backgroundImage: UINavigationBar.appearance().backgroundImageForBarMetrics(UIBarMetrics.Default)!)
    
     private lazy var rightBtn: UIButton = UIButton(cancelTarget:self, action: #selector(PPSearchViewController.rightBtnAction))

    
     private func addNotification(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PPSearchViewController.tagButtonAction), name: Notification_Search_Tag, object: nil)
     }
    
    
     private func removeNotification(){
     NSNotificationCenter.defaultCenter().removeObserver(self, name:Notification_Search_Tag , object: nil)
     }
    
    
    @objc private func tagButtonAction(){
 
        print("notification")
    }
    
    
    @objc private func rightBtnAction(){
     
        
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension PPSearchViewController:UISearchBarDelegate {

    
    
    

}




