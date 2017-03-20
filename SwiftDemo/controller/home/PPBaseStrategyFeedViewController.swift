//
//  PPBaseStrategyFeedViewController.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/26.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

private let cellIdentify = "BaseStrategyCell"

protocol PPBaseStrategyFeedViewControllerDelegate:NSObjectProtocol {
    func clickChanelIndex(_ dicrection: TableViewScrollingToDicrection)
}

class PPBaseStrategyFeedViewController: PPBaseViewController {

    var lastContentOffsetY:CGFloat = 0.0
    
    weak var delegate :PPBaseStrategyFeedViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupFrame()
     }

    fileprivate func setupUI(){
    view.addSubview(tableView)
    }
    
    fileprivate func setupFrame(){
    tableView.frame = view.bounds
    }
    
    //MARK lazy tableView
    lazy var tableView:UITableView =  {
       let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Color_GlobalBackground
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.sectionFooterHeight = 0.0001
        tableView.sectionHeaderHeight = 0.0001
        tableView.register(UINib(nibName: "BaseStrategyCell", bundle: Bundle.main), forCellReuseIdentifier: cellIdentify)
        return tableView
    }()

}

extension PPBaseStrategyFeedViewController:UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentify)
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastContentOffsetY = scrollView.contentOffset.y
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if lastContentOffsetY < scrollView.contentOffset.y {
           if let callback = delegate {
              callback.clickChanelIndex(TableViewScrollingToDicrection.tableViewScrollingToUp)
            }
        }else {
            if let callback = delegate {
                callback.clickChanelIndex(TableViewScrollingToDicrection.tableViewScrollingToDown)
            }
        }
    }
}



