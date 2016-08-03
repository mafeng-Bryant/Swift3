//
//  ClassfiyViewController.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/22.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

class ClassfiyViewController: PPBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         setupUI()
    }

    override func viewWillAppear(animated: Bool) {
       super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      setupFrame()
    }
    
    private func setupUI(){
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = Color_GlobalBackground
        navigationItem.titleView = titleView
        navigationItem.rightBarButtonItem = UIBarButtonItem(chooseGifTarget: self, action: #selector(ClassfiyViewController.searchGifBtnAction))
        navigationItem.rightBarButtonItem?.customView?.alpha = 0;
        view.addSubview(searchBar)
        view.addSubview(scrollView)
        scrollView.addSubview(strategyVC.view)
        addChildViewController(strategyVC)
        scrollView.addSubview(singleVC.view)
        addChildViewController(singleVC)
    }
    
    private lazy var searchBar: UISearchBar =  UISearchBar(searchGifdelegate: self, backgroundColor:UIColor(white: 0, alpha: 0.05), backgroundImage:UIImage.imageWithColor(UIColor.whiteColor(), size: CGSizeZero))
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.delegate = self
        view.showsHorizontalScrollIndicator = false
        view.pagingEnabled = true
        return view
    }()
    
    private lazy var singleVC: SingleGifViewController = SingleGifViewController()
    
    private lazy var strategyVC: StrategyViewController = StrategyViewController()

    @objc private func searchGifBtnAction(){
    
        
    }
    
    private lazy var titleView:PPTitleView = {
       let titleView = PPTitleView()
        titleView.delegate = self
        return titleView
    }()
    
    
    private func setupFrame(){
        titleView.frame = CGRectMake(0, 0, 120, 44)
        self.searchBar.frame = CGRectMake(0, 0, self.view.bounds.width, 44.0)
        self.scrollView.frame = CGRectMake(0, CGRectGetMaxY(self.searchBar.frame), self.view.bounds.width, self.view.bounds.height - self.searchBar.bounds.height - 44.0)
        self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.width * 2.0, self.scrollView.bounds.height)
        self.strategyVC.view.frame = self.scrollView.bounds
        self.singleVC.view.frame = CGRectMake(CGRectGetWidth(self.scrollView.frame), 0, self.scrollView.bounds.width, self.scrollView.bounds.height)
   }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ClassfiyViewController:PPTitleViewDelegate {
    func clickIndex(index: NSInteger) {
        scrollView.setContentOffset(CGPointMake(CGFloat(index) * scrollView.bounds.width, 0), animated: true)
    }
}

extension ClassfiyViewController:UISearchBarDelegate {
    

 
}

extension ClassfiyViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        navigationItem.rightBarButtonItem?.customView?.alpha = scrollView.contentOffset.x / scrollView.bounds.width;
        titleView.scrollLine(scrollView.bounds.width, offsetX: scrollView.contentOffset.x);
    }
}









