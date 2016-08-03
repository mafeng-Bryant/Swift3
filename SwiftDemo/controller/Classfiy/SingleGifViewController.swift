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
    private var selectedColumn = 0
    private let headerDatas:[String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
            setUpUI()
    }
    
    override func viewWillLayoutSubviews() {
       super.viewWillLayoutSubviews()
        setupUIFrame()
    }
    
    private func setupUIFrame(){
        let scale:CGFloat = 0.25
       tableView.frame = CGRectMake(0, 0, view.bounds.width * scale, view.bounds.height)
       collectionView.frame = CGRectMake(CGRectGetMaxX(tableView.frame), 0, view.bounds.width * (1-scale), view.bounds.height)
     }

        private func setUpUI(){
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(tableView);
        view.addSubview(collectionView)
    }
    
    private lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Color_GlobalBackground
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionFooterHeight = 0.0001
        tableView.sectionHeaderHeight = 0.0001
        tableView.registerNib(UINib(nibName: "SingleGifColumnCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: columnCellID)
        return tableView;
    }()
    
    private lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: collectionLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.registerNib(UINib(nibName: "SingleGifCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        collectionView.registerNib(UINib(nibName: "SingleGifSectionView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionID)
        let section = NSBundle.mainBundle().loadNibNamed("SingleGifSectionView", owner: self, options: nil).last!
        let collectionViewLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        collectionViewLayout.headerReferenceSize = CGSize(width: ScreenWidth, height: section.size.height)
        self.headerSize = collectionViewLayout.headerReferenceSize
        return collectionView
     }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SingleGifViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 18
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(columnCellID) as! SingleGifColumnCell
        cell.changeStatus(indexPath.row == selectedColumn ? true : false)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      selectedColumn = indexPath.row
      tableView.reloadData()
      //滚动商品列表
        
        
    }
}

extension SingleGifViewController: UICollectionViewDelegate,UICollectionViewDataSource
{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 6
    }
  
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 18
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! SingleGifCell
       //scroll tableView
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    //header collectionView
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let sectionView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: sectionID, forIndexPath: indexPath) as! SingleGifSectionView
        sectionView.setHeaderData(headerDatas[indexPath.section])
        return sectionView
     }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsetsMake(0, cellMargin, 0, cellMargin);
        }
        return UIEdgeInsetsMake(cellMargin, cellMargin, cellMargin, cellMargin);
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
       return headerSize!
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = (collectionView.bounds.width - (cellMargin * CGFloat(cellColumns + 1))) / CGFloat(cellColumns)
        let height = width / cellScale
        return CGSize(width: width, height: height)
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

/// 分组头部
class SingleGifSectionView: UICollectionReusableView {
    
    @IBOutlet weak var titleLbl: UILabel!
    func setHeaderData(titleString:String){
      titleLbl.text = titleString
    }
    
    
}

