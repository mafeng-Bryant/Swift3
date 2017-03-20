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
    
    fileprivate func setupUI(){
       title = "选礼神器"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView:rightBtn)
        view.addSubview(categoryView)
        view.addSubview(sortView)
    }
    
    
    fileprivate func setupFrame(){
        let height:CGFloat = 44.0
        categoryView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: view.bounds.width, height: height))
        collectionView.frame.origin.y = height
        collectionView.frame.size.height = view.bounds.height - height
   }
    
    
    fileprivate lazy var sortView:PopoverSortView = PopoverSortView(frame: CGRect(x: ScreenWidth - 155,y: 0,width: 155,height: 190))
    
    fileprivate lazy var categoryView:PopoverSortGifView = {
     let view = PopoverSortGifView.popoverSortGifView()
     return view
   }()
    
    
    fileprivate lazy var leftBtn:UIButton = UIButton(backTarget:self, action:#selector(PPSearchGifViewController.leftBtnAction))
    
    fileprivate lazy var rightBtn:UIButton = UIButton(sortTarget:self, action:#selector(PPSearchGifViewController.rightBtnAction))
    
    
    //event response
    @objc fileprivate func leftBtnAction(){
     navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func rightBtnAction(){
        if sortView.isHidden {
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
