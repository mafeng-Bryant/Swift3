//
//  PPBaseStrategyFeedViewController.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/26.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

private let cellIdentify = "BaseStrategyCell"

class PPBaseStrategyFeedViewController: PPBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupFrame()
     }

    private func setupUI(){
    view.addSubview(tableView)
    }
    
    private func setupFrame(){
    tableView.frame = view.bounds
    }
    
    //MARK lazy tableView
    lazy var tableView:UITableView =  {
       let tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Color_GlobalBackground
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.sectionFooterHeight = 0.0001
        tableView.sectionHeaderHeight = 0.0001
        tableView.registerNib(UINib(nibName: "BaseStrategyCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: cellIdentify)
        return tableView
    }()

}

extension PPBaseStrategyFeedViewController:UITableViewDelegate,UITableViewDataSource {

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentify)
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 260
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
   //     navigationController?.pushViewController(CommonFetureViewController(), animated: true)
    }
}



