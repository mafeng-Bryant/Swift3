//
//  StrategyColumnCell.swift
//  Liwushuo
//
//  Created by hans on 16/7/10.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

private let cellColumns = 3
private let cellMargin:CGFloat = 10.0
/// cellxib宽高比例
private let cellScale:CGFloat = 340.0 / 90.0
private let cellID = "StrategyColumnCellCell"

class StrategyColumnCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: "StrategyColumnCellCell", bundle: nil), forCellWithReuseIdentifier: cellID)
    }
}

// MARK: - 代理
extension StrategyColumnCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! StrategyColumnCellCell
        cell.viewAllcoverView.isHidden = indexPath.row == 14 ? false : true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let tabBarViewController = UIApplication.sharedApplication().keyWindow?.rootViewController as! TabBarController
//        let navigationController = tabBarViewController.viewControllers![tabBarViewController.selectedIndex] as! NavigationController
//        if indexPath.row == 14 {
////            navigationController.pushViewController( AllColumnViewController(), animated: true)
//        } else {
//        //    navigationController.pushViewController(ColumnListViewController(), animated: true)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let height = (collectionView.bounds.height - (cellMargin * CGFloat(cellColumns + 1))) / CGFloat(cellColumns)
        let width = height * cellScale
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(cellMargin, cellMargin, cellMargin, cellMargin);
    }
    
}
