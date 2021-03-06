//
//  BaseGoodsCell.swift
//  Liwushuo
//
//  Created by hans on 16/7/1.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

class BaseGoodsCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoImageView.layer.masksToBounds = true
        photoImageView.contentMode =  UIViewContentMode.scaleAspectFill;
        photoImageView.image = UIImage(named: "goods_\(Int(arc4random() % 10) + 1).jpg")
    }
}


