//
//  PPChoiceStrategyFeedController.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/26.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

class PPChoiceStrategyFeedController: PPBaseStrategyFeedViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
          setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupFrame()
    }
    
    fileprivate func setupUI(){
      headerView.addSubview(banner)
      headerView.addSubview(top)
      tableView.tableHeaderView = headerView
    }
    
    fileprivate func setupFrame(){
        banner.frame = CGRect(x: 0,y: 0,width: self.tableView.bounds.width, height:170)
        top.frame = CGRect(x: 0,y: banner.bounds.height,width: self.tableView.bounds.width,height: 120)
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: banner.bounds.height + top.bounds.height + 10.0)
        tableView.tableHeaderView = headerView
    }
    
    // MARK: -懒加载
    fileprivate lazy var headerView: UIView = UIView()
    
    fileprivate lazy var banner:PPBannerCollectionView = PPBannerCollectionView(frame:CGRect.zero, collectionViewLayout: PPBannerFlowLayout())
    
    fileprivate lazy var top:PPTopCollectionView = PPTopCollectionView(frame:CGRect.zero, collectionViewLayout: PPTopFlowLayout())
}
