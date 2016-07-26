//
//  HomeViewController.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/22.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

class HomeViewController: PPBaseViewController {

    var categotyTitles : [String] {
        return ["AAA","BBB","CCCDDD","AAA","BBB","CCCDDD","AAA","BBB","CCCDDD","AAA","BBB","CCCDDD"]
    }

    //scrollview的分类视图
    var cacheCategoryViews = [UIView]();

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpUIFrame()
    }
    
    private  func setUpUI(){
       view.backgroundColor = Color_GlobalBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(gitTarget: self,action: #selector(HomeViewController.giftAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(searchTarget: self,action:  #selector(HomeViewController.searchBarAction))
        navigationItem.titleView = titleImageView
        view.addSubview(scrollView)
        view.addSubview(popoverCategoryView)
       
        for i in 0..<categotyTitles.count {
           
            
            
        
        }
        
        
    }
    
    private lazy var titleImageView:UIImageView = {
        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.bounds = CGRectMake(0, 0, 20 * (image!.size.width / image!.size.height), 20)
       return imageView
    }()
    
    private lazy var scrollView: UIScrollView = {
       let view = UIScrollView()
        view.delegate = self
        view.showsHorizontalScrollIndicator = false
        view.pagingEnabled = true
        return view;
    }()
    
    private lazy var popoverCategoryView :PopoverCategoryView = {
     var view = PopoverCategoryView.popoverCategoryView()
     view.categoryTitles = self.categotyTitles
     view.delegate = self
     return view
    }()
    
    private func setUpUIFrame(){
     popoverCategoryView.frame  = CGRectMake(0, 0, view.bounds.width, 44)
     scrollView.frame = CGRectMake(0, CGRectGetMaxY(popoverCategoryView.frame), view.frame.size.width, view.bounds.height - 44 - popoverCategoryView.bounds.height)
        
        
     scrollView.contentSize = CGSizeMake(CGFloat(categotyTitles.count) * scrollView.frame.size.width, 0)
      print("scrollView = %@",scrollView)
   }
    
    
    @objc private func giftAction(){
     
        
        
    }
    
    @objc private func searchBarAction(){
    
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension HomeViewController: PopoverCategoryViewDelegate
{
    func clickChanelIndex(index: NSInteger){
     print("index %ld click",index)
    }
}


extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
       let index =  scrollView.contentOffset.x / scrollView.frame.size.width
       print("index = %ld",index)
    }
}





