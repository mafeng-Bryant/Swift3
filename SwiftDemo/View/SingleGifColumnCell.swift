//
//  SingleGifColumnCell.swift
//  Liwushuo
//
//  Created by hans on 16/7/11.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

class SingleGifColumnCell: UITableViewCell {

    @IBOutlet weak var edgeLineView: UIView!
    @IBOutlet weak var titleBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        edgeLineView.isHidden = true
        titleBtn.setTitleColor(UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0), for: UIControlState())
        titleBtn.setTitleColor(UIColor(red: 251.0/255.0, green: 45.0/255.0, blue: 71.0/255.0, alpha: 1.0), for: UIControlState.selected)
        
        titleBtn.setBackgroundImage(UIImage.imageWithColor(Color_GlobalBackground, size: CGSize.zero), for: UIControlState())
        titleBtn.setBackgroundImage(UIImage.imageWithColor(UIColor.white, size: CGSize.zero), for: UIControlState.selected)
    }
    
    func setHeaderTitle(_ title:String) {
     titleBtn.setTitle(title, for: UIControlState())
   }
    
    func changeStatus(_ selected: Bool) {
        titleBtn.isSelected = selected
        edgeLineView.isHidden = !selected
    }
}
