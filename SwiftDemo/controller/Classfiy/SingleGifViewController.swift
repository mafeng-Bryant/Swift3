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

    
    fileprivate var headerSize:CGSize?
    fileprivate let headerDatas:[String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R"]
    var isScrollTabelView:Bool = true
    var column:NSInteger = 0
    var offsetY:CGFloat = CGFloat.greatestFiniteMagnitude
    
    override func viewDidLoad() {
        super.viewDidLoad()
            setUpUI()
    }
    
    override func viewWillLayoutSubviews() {
       super.viewWillLayoutSubviews()
        setupUIFrame()
    }
    
    fileprivate func setupUIFrame(){
        let scale:CGFloat = 0.25
       tableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width * scale, height: view.bounds.height)
       collectionView.frame = CGRect(x: tableView.frame.maxX, y: 0, width: view.bounds.width * (1-scale), height: view.bounds.height)
     }

        fileprivate func setUpUI(){
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.white
        view.addSubview(tableView);
        view.addSubview(collectionView)
    }
    
    fileprivate lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Color_GlobalBackground
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.isPagingEnabled = true
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionFooterHeight = 0.0001
        tableView.sectionHeaderHeight = 0.0001
        tableView.register(UINib(nibName: "SingleGifColumnCell", bundle: Bundle.main), forCellReuseIdentifier: columnCellID)
        return tableView;
    }()
    
    fileprivate lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UINib(nibName: "SingleGifCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        collectionView.register(UINib(nibName: "SingleGifSectionView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionID)
        let section = Bundle.main.loadNibNamed("SingleGifSectionView", owner: self, options: nil)?.last!
        let collectionViewLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        collectionViewLayout.headerReferenceSize = CGSize(width: ScreenWidth, height: 60)
        self.headerSize = collectionViewLayout.headerReferenceSize
        return collectionView
     }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SingleGifViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headerDatas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: columnCellID) as! SingleGifColumnCell
        cell.setHeaderTitle(headerDatas[indexPath.row])
        cell.changeStatus(indexPath.row == column ? true : false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let selectIndexPath = IndexPath(row: 0,section: indexPath.row)
        column = selectIndexPath.section
        isScrollTabelView = false
        self.tableView.reloadData()
        //set offsetY
        let cell = self.tableView.cellForRow(at: indexPath)
        if cell!.center.y < self.tableView.bounds.height * 0.5 {
            self.tableView.setContentOffset(CGPoint.zero, animated: true)
         } else if  self.tableView.contentSize.height >  view.bounds.height && cell!.center.y > view.bounds.height * 0.5 && cell!.center.y < (self.tableView.contentSize.height -  view.bounds.height * 0.5) {
            self.tableView.setContentOffset(CGPoint(x: 0,y: cell!.frame.origin.y + cell!.bounds.height * 0.5 - view.bounds.height * 0.5), animated: true)
         } else {
            self.tableView.setContentOffset(CGPoint(x: 0,y: max(0,self.tableView.contentSize.height - self.tableView.bounds.size.height)), animated: true)
        }
        //滚动商品列表
        collectionView.scrollToItem(at: selectIndexPath, at: UICollectionViewScrollPosition.top, animated: true)
    }

}

extension SingleGifViewController: UICollectionViewDelegate,UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 9
    }
  
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return headerDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SingleGifCell
        return cell
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView.isKind(of: UICollectionView.self) {
             isScrollTabelView = true
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isKind(of: UIScrollView.self) {
         if isScrollTabelView == true {
            let point = self.view.convert(self.collectionView.center, to: self.collectionView)
            var indexPath = self.collectionView.indexPathForItem(at: point)
            if indexPath == nil {
                indexPath = IndexPath(row: 0, section: 0)
            }
             if indexPath!.section == 0 {
                let array = self.collectionView.indexPathsForVisibleSupplementaryElements(ofKind: UICollectionElementKindSectionHeader)
                if array.count > 0 {
                    if (array[0].section == 0 || array[0].section == 1) {
                        let path = IndexPath(row: 0, section: 0)
                        column = 0
                        self.tableView.scrollToRow(at: path, at: UITableViewScrollPosition.none, animated: false)
                        self.tableView.reloadData()
                    }
                    return
                }
            }
           let path = IndexPath(row: indexPath!.section, section: 0)
            column = path.row
            if column <= headerDatas.count  {
                self.tableView.scrollToRow(at: path, at: UITableViewScrollPosition.none, animated: false)
                self.tableView.reloadData()
            }
            }
        }
    }


    
    //header collectionView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionID, for: indexPath) as! SingleGifSectionView
        sectionView.setHeaderData(headerDatas[indexPath.section])
        return sectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsetsMake(0, cellMargin, 0, cellMargin);
        }
        return UIEdgeInsetsMake(cellMargin, cellMargin, cellMargin, cellMargin);
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize.zero
        }
        return headerSize!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - (cellMargin * CGFloat(cellColumns + 1))) / CGFloat(cellColumns)
        let height = width / cellScale
        return CGSize(width: width, height: height)
    }
}


class collectionLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        minimumInteritemSpacing = cellMargin * 0.5
        minimumLineSpacing = cellMargin
        scrollDirection = UICollectionViewScrollDirection.vertical
     }
}

/// 分组头部
class SingleGifSectionView: UICollectionReusableView {
    @IBOutlet weak var titleLbl: UILabel!
    func setHeaderData(_ titleString:String){
      titleLbl.text = titleString
    }
}

