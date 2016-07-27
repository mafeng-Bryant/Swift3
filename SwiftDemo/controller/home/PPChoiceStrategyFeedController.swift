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
    
    private func setupUI(){
      headerView.addSubview(banner)
      headerView.addSubview(top)
      tableView.tableHeaderView = headerView
    }
    
    private func setupFrame(){
    //
        
        
    }
    
    // MARK: -懒加载
    private lazy var headerView: UIView = UIView()
    
    private lazy var banner:PPBannerCollectionView = PPBannerCollectionView(frame:CGRectZero, collectionViewLayout: PPBannerFlowLayout())
    
    private lazy var top:PPTopCollectionView = PPTopCollectionView(frame:CGRectZero, collectionViewLayout: PPTopFlowLayout())
}
