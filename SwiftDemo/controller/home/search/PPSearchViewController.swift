//
//  PPSearchViewController.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/28.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

private let searchCellIdentifier = "SearchGiftCell"

class PPSearchViewController: PPBaseViewController {

    private var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupUI()
         addNotification()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        self.performSelector(#selector(PPSearchViewController.searchBarBecomeFirstResponder), withObject: nil, afterDelay: 0.3)
    }
    
   @objc private func searchBarBecomeFirstResponder(){
      searchBar.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotification()
    }
   
    private func setupUI(){
        view.backgroundColor = Color_GlobalBackground
        navigationItem.titleView = searchBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
       //tableView
       tableView = UITableView(frame: view.bounds, style: UITableViewStyle.Plain)
       view.addSubview(tableView!)
       tableView?.delegate = self
       tableView?.dataSource = self
       tableView?.sectionHeaderHeight = 0.01
       tableView?.sectionFooterHeight = 0.01
       tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
       tableView?.backgroundColor = Color_GlobalBackground
       tableView?.tableHeaderView = searchHeadView
       tableView?.registerNib(UINib(nibName: "SearchGiftCell",bundle: NSBundle.mainBundle() ), forCellReuseIdentifier: searchCellIdentifier)
       view.addSubview(sortView)
    }
    
    private lazy var sortView: UIView = {
    
    
    
     return UIView()
    
    }()
    
    private lazy var searchHeadView: SearchHeaderView = {
          let searchView = SearchHeaderView.init(layoutFinish: { (height) in
            self.searchHeadView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: height)
            self.tableView?.tableHeaderView = self.searchHeadView
        })
      return searchView
    }()
    
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
     self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension PPSearchViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(searchCellIdentifier)
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        navigationController?.pushViewController(PPSearchGifViewController(), animated: true)
    }
}

extension PPSearchViewController:UISearchBarDelegate {
   
    
    
    

}




