//
//  PopoverSortCell.swift
//  Liwushuo
//
//  Created by hans on 16/7/5.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

class PopoverSortCell: UITableViewCell {

    @IBOutlet weak var textLab: UILabel!
    @IBOutlet weak var selectBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      // backgroundColor = UIColor.blackColor()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
