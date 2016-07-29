//
//  PPSearchGifViewController.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/28.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

class PPSearchGifViewController: PPBaseGoodsFeedController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupFrame()
    }
    
    private func setupUI(){
       title = "选礼神器"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView:rightBtn)
        view.addSubview(categoryView)
        view.addSubview(sortView)
    }
    
    
    private func setupFrame(){
        let height:CGFloat = 44.0
        categoryView.frame = CGRect(origin: CGPointZero, size: CGSizeMake(view.bounds.width, height))
        collectionView.frame.origin.y = height
        collectionView.frame.size.height = view.bounds.height - height
   }
    
    
    private lazy var sortView:PopoverSortView = PopoverSortView(frame: CGRectMake(ScreenWidth - 155,0,155,190))
    
    private lazy var categoryView:PopoverSortGifView = {
     let view = PopoverSortGifView.popoverSortGifView()
     return view
   }()
    
    
    private lazy var leftBtn:UIButton = UIButton(backTarget:self, action:#selector(PPSearchGifViewController.leftBtnAction))
    
    private lazy var rightBtn:UIButton = UIButton(sortTarget:self, action:#selector(PPSearchGifViewController.rightBtnAction))
    
    
    //event response
    @objc private func leftBtnAction(){
     navigationController?.popViewControllerAnimated(true)
    }
    
    @objc private func rightBtnAction(){
        if sortView.hidden {
            sortView.showSortView()
        }else {
          sortView.hiddenSortView()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
