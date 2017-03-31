//
//  HomeViewController.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/22.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

class HomeViewController: PPBaseViewController {

    
    var categotyTitles: [NSString]
    {
        return ["精选", "海淘", "创意生活", "送女票", "科技范", "送爸妈", "送基友", "送闺蜜", "送同事", "送宝贝", "设计感", "文艺范", "奇葩搞怪", "萌萌哒"]
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
    
    fileprivate  func setUpUI(){
        view.backgroundColor = Color_GlobalBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(gitTarget: self,action: #selector(HomeViewController.giftAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(searchTarget: self,action:  #selector(HomeViewController.searchBarAction))
        self.title = "Swift3"
        view.addSubview(scrollView)
        view.addSubview(popoverCategoryView)
        for i in 0..<categotyTitles.count {
            let categoryVC = i == 0 ? PPChoiceStrategyFeedController() : PPCommonStrategyFeedController()
            categoryVC.delegate = self
            self.addChildViewController(categoryVC)
            scrollView.addSubview(categoryVC.view)
            cacheCategoryViews.append(categoryVC.view)
        }
    }
    
    fileprivate lazy var titleImageView:UIImageView = {
        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.bounds = CGRect(x: 0, y: 0, width: 20 * (image!.size.width / image!.size.height), height: 20)
       return imageView
    }()
    
    fileprivate lazy var scrollView: UIScrollView = {
       let view = UIScrollView()
        view.delegate = self
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        return view;
    }()
    
    fileprivate lazy var popoverCategoryView :PopoverCategoryView = {
     var view = PopoverCategoryView.popoverCategoryView()
     view.categoryTitles = self.categotyTitles
     view.delegate = self
     return view
    }()
    
    fileprivate func setUpUIFrame(){
      popoverCategoryView.frame  = CGRect(x: 0, y: 0, width: view.bounds.width, height: 44)
      scrollView.frame = CGRect(x: 0, y: popoverCategoryView.frame.maxY, width: view.frame.size.width, height: view.bounds.height - 44 - popoverCategoryView.bounds.height)
        for i in 0..<cacheCategoryViews.count {
            let view = cacheCategoryViews[i];
            view.frame = CGRect(x: scrollView.frame.width * CGFloat(i), y: 0, width: scrollView.frame.width, height: scrollView.frame.height);
       }
      scrollView.contentSize = CGSize(width: CGFloat(categotyTitles.count) * scrollView.frame.size.width, height: 0)
   }
    
    @objc fileprivate func giftAction(){
     
    }
    
    @objc fileprivate func searchBarAction(){
     navigationController?.pushViewController(PPSearchViewController(), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HomeViewController: PPBaseStrategyFeedViewControllerDelegate
{
    func clickChanelIndex(_ dicrection: TableViewScrollingToDicrection) {
        if dicrection == TableViewScrollingToDicrection.tableViewScrollingToDown {
           UIView.animate(withDuration: 0.08, animations: {
                self.popoverCategoryView.frame.origin.y = 0
                self.scrollView.frame.origin.y = max(0,self.popoverCategoryView.frame.maxY)
                self.scrollView.frame.size.height = self.view.bounds.height - self.scrollView.frame.origin.y - 44
            })
          }else if dicrection == TableViewScrollingToDicrection.tableViewScrollingToUp{
            UIView.animate(withDuration: 0.08, animations: {
                self.popoverCategoryView.frame.origin.y = -self.popoverCategoryView.bounds.height
                self.scrollView.frame.origin.y = max(0,self.popoverCategoryView.frame.maxY)
                self.scrollView.frame.size.height = self.view.bounds.height - self.scrollView.frame.origin.y - 44
            })
        }
    }
}

extension HomeViewController: PopoverCategoryViewDelegate
{
    func clickChanelIndex(_ index: NSInteger){
     scrollView.setContentOffset(CGPoint(x: CGFloat(index) * scrollView.bounds.width, y: 0), animated: true)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       let index =  scrollView.contentOffset.x / scrollView.frame.size.width
       popoverCategoryView.scrollCategoryBtnByIndex(NSInteger(index))
    }
}

