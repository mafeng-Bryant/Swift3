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
    
    private  func setUpUI(){
        view.backgroundColor = Color_GlobalBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(gitTarget: self,action: #selector(HomeViewController.giftAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(searchTarget: self,action:  #selector(HomeViewController.searchBarAction))
        self.title = "SwiftDemo"
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
        for i in 0..<cacheCategoryViews.count {
            let view = cacheCategoryViews[i];
            view.frame = CGRectMake(scrollView.frame.width * CGFloat(i), 0, scrollView.frame.width, scrollView.frame.height);
       }
      scrollView.contentSize = CGSizeMake(CGFloat(categotyTitles.count) * scrollView.frame.size.width, 0)
   }
    
    @objc private func giftAction(){
     
    }
    
    @objc private func searchBarAction(){
     navigationController?.pushViewController(PPSearchViewController(), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HomeViewController: PPBaseStrategyFeedViewControllerDelegate
{
    func clickChanelIndex(dicrection: TableViewScrollingToDicrection) {
        if dicrection == TableViewScrollingToDicrection.TableViewScrollingToDown {
           UIView.animateWithDuration(0.08, animations: {
                self.popoverCategoryView.frame.origin.y = 0
                self.scrollView.frame.origin.y = max(0,CGRectGetMaxY(self.popoverCategoryView.frame))
                self.scrollView.frame.size.height = self.view.bounds.height - self.scrollView.frame.origin.y - 44
            })
          }else if dicrection == TableViewScrollingToDicrection.TableViewScrollingToUp{
            UIView.animateWithDuration(0.08, animations: {
                self.popoverCategoryView.frame.origin.y = -self.popoverCategoryView.bounds.height
                self.scrollView.frame.origin.y = max(0,CGRectGetMaxY(self.popoverCategoryView.frame))
                self.scrollView.frame.size.height = self.view.bounds.height - self.scrollView.frame.origin.y - 44
            })
        }
    }
}

extension HomeViewController: PopoverCategoryViewDelegate
{
    func clickChanelIndex(index: NSInteger){
     scrollView.setContentOffset(CGPointMake(CGFloat(index) * scrollView.bounds.width, 0), animated: true)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
       let index =  scrollView.contentOffset.x / scrollView.frame.size.width
       popoverCategoryView.scrollCategoryBtnByIndex(NSInteger(index))
    }
}

