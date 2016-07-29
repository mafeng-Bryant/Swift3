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
       self.view.addSubview(searchBar)
       self.view.addSubview(scrollView)
        
        
    }
    
    private lazy var searchBar: UISearchBar =  UISearchBar(searchGifdelegate: self, backgroundColor:UIColor(white: 0, alpha: 0.05), backgroundImage:UIImage.imageWithColor(UIColor.whiteColor(), size: CGSizeZero))
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.delegate = self
        view.showsHorizontalScrollIndicator = false
        view.pagingEnabled = true
        return view
    }()
    
    
    @objc private func searchGifBtnAction(){
    
        
    }
    
    private lazy var titleView:PPTitleView = {
       let titleView = PPTitleView()
        titleView.delegate = self
        return titleView
    }()
    
    
    private func setupFrame(){
      titleView.frame = CGRectMake(0, 0, 120, 44)
        
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ClassfiyViewController:PPTitleViewDelegate {
 
    func clickIndex(index: NSInteger) {
        
        
    }

}

extension ClassfiyViewController:UISearchBarDelegate {

 
    

}

extension ClassfiyViewController:UIScrollViewDelegate {

 
    
    

}









