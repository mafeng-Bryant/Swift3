//
//  SingleGifViewController.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/30.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

private let cellColumns = 3
private let cellMargin:CGFloat = 10.0
private let cellScale:CGFloat = 100.0/140.0 //cell的宽高比
private let cellID = "SingleGifCell"
private let sectionID = "SingleGifSectionView"
private let columnCellID = "columnCell"

class SingleGifViewController: PPBaseViewController {

    
    private var headerSize:CGSize?
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
            setUpUI()
    }
    
    override func viewWillLayoutSubviews() {
       super.viewWillLayoutSubviews()
        setupUIFrame()
    }
    
    private func setupUIFrame(){
    
    
        
    }

    

        private func setUpUI(){
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(tableView);
        view.addSubview(collectionView)
    }
    
    private lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        
        
        return tableView;
    }()
    
    private lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: collectionLayout())
        return collectionView
    }()
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


class collectionLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        minimumInteritemSpacing = cellMargin * 0.5
        minimumLineSpacing = cellMargin
        scrollDirection = UICollectionViewScrollDirection.Vertical
     }
}


