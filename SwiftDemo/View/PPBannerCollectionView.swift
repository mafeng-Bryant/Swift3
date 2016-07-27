//
//  PPBannerCollectionView.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/27.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit


class PPBannerCollectionView: UICollectionView {

    
    
    
    
    
    
}



class PPBannerFlowLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        super.prepareLayout()
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = UICollectionViewScrollDirection.Horizontal
    }
}