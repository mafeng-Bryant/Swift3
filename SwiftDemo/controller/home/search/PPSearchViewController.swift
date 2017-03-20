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

    fileprivate var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupUI()
         addNotification()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.performSelector(#selector(PPSearchViewController.searchBarBecomeFirstResponder), withObject: nil, afterDelay: 0.3)
    }
    
   @objc fileprivate func searchBarBecomeFirstResponder(){
      searchBar.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotification()
    }
   
    fileprivate func setupUI(){
        view.backgroundColor = Color_GlobalBackground
        navigationItem.titleView = searchBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
       //tableView
       tableView = UITableView(frame: view.bounds, style: UITableViewStyle.plain)
       view.addSubview(tableView!)
       tableView?.delegate = self
       tableView?.dataSource = self
       tableView?.sectionHeaderHeight = 0.01
       tableView?.sectionFooterHeight = 0.01
       tableView?.separatorStyle = UITableViewCellSeparatorStyle.none
       tableView?.backgroundColor = Color_GlobalBackground
       tableView?.tableHeaderView = searchHeadView
       tableView?.register(UINib(nibName: "SearchGiftCell",bundle: Bundle.main ), forCellReuseIdentifier: searchCellIdentifier)
        tableView?.tableHeaderView = searchHeadView

       view.addSubview(sortView)
    }
    
    fileprivate lazy var sortView: UIView = {
    
    
    
     return UIView()
    
    }()
    
    fileprivate lazy var searchHeadView: SearchHeaderView = {
          let searchView = SearchHeaderView.init(layoutFinish: { (height) in
            self.searchHeadView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: height)
            self.tableView?.tableHeaderView = self.searchHeadView
        })
      return searchView
    }()
    
    fileprivate lazy var searchBar:UISearchBar = UISearchBar(searchGifdelegate: self, backgroundColor: UIColor.white, backgroundImage: UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default)!)
    
     fileprivate lazy var rightBtn: UIButton = UIButton(cancelTarget:self, action: #selector(PPSearchViewController.rightBtnAction))

     fileprivate func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(PPSearchViewController.tagButtonAction), name: NSNotification.Name(rawValue: "Notif_BtnAction_SearchTag"), object: nil)
     }
    
     fileprivate func removeNotification(){
     NotificationCenter.default.removeObserver(self, name:NSNotification.Name(rawValue: Notification_Search_Tag) , object: nil)
     }
    
    @objc fileprivate func tagButtonAction(){
        let searchResult = SearchResultViewController()
        navigationController?.pushViewController(searchResult, animated: true)
    }
    
    
    @objc fileprivate func rightBtnAction(){
     self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension PPSearchViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: searchCellIdentifier)
        cell!.selectionStyle = UITableViewCellSelectionStyle.none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(PPSearchGifViewController(), animated: true)
    }
}

extension PPSearchViewController:UISearchBarDelegate {
   
    
    
    

}




