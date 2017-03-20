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

    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      setupFrame()
    }
    
    fileprivate func setupUI(){
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
    
    fileprivate lazy var searchBar: UISearchBar =  UISearchBar(searchGifdelegate: self, backgroundColor:UIColor(white: 0, alpha: 0.05), backgroundImage:UIImage.imageWithColor(UIColor.white, size: CGSize.zero))
    
    fileprivate lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.delegate = self
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        return view
    }()
    
    fileprivate lazy var singleVC: SingleGifViewController = SingleGifViewController()
    
    fileprivate lazy var strategyVC: StrategyViewController = StrategyViewController()

    @objc fileprivate func searchGifBtnAction(){
    
        
    }
    
    fileprivate lazy var titleView:PPTitleView = {
       let titleView = PPTitleView()
        titleView.delegate = self
        return titleView
    }()
    
    
    fileprivate func setupFrame(){
        titleView.frame = CGRect(x: 0, y: 0, width: 120, height: 44)
        self.searchBar.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44.0)
        self.scrollView.frame = CGRect(x: 0, y: self.searchBar.frame.maxY, width: self.view.bounds.width, height: self.view.bounds.height - self.searchBar.bounds.height - 44.0)
        self.scrollView.contentSize = CGSize(width: self.scrollView.bounds.width * 2.0, height: self.scrollView.bounds.height)
        self.strategyVC.view.frame = self.scrollView.bounds
        self.singleVC.view.frame = CGRect(x: self.scrollView.frame.width, y: 0, width: self.scrollView.bounds.width, height: self.scrollView.bounds.height)
   }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ClassfiyViewController:PPTitleViewDelegate {
    func clickIndex(_ index: NSInteger) {
        scrollView.setContentOffset(CGPoint(x: CGFloat(index) * scrollView.bounds.width, y: 0), animated: true)
    }
}

extension ClassfiyViewController:UISearchBarDelegate {
    

 
}

extension ClassfiyViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navigationItem.rightBarButtonItem?.customView?.alpha = scrollView.contentOffset.x / scrollView.bounds.width;
        titleView.scrollLine(scrollView.bounds.width, offsetX: scrollView.contentOffset.x);
    }
}









