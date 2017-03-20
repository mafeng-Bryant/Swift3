//
//  MaskCoverView.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/27.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

class MaskCoverView: UIView {

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
         backgroundColor = UIColor(white: 0,alpha: 0.3)
    }
    
    required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
}
