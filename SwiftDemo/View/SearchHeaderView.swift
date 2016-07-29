//
//  SearchHeaderView.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/28.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

class SearchHeaderView: UIView {
    var temBtn:UIButton?
    let btnTitles = ["零食", "手机壳", "双肩包", "钱包", "凉鞋", "手表", "情侣", "泳衣", "杯子", "连衣裙", "手链", "宿舍"]
   //swift block
    var layoutFinishBlock: ((height: CGFloat) ->())?
    
    init(layoutFinish: (height: CGFloat) ->()) {
        super.init(frame: CGRectZero)
        layoutFinishBlock = layoutFinish
        setupUI()
    }
    
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupFrame()
    }
    
    //private metnod
    private func setupFrame(){
    titleLbl.frame = CGRectMake(0, 0, ScreenWidth, 30.0)
    line.frame = CGRectMake(0, CGRectGetMaxY(titleLbl.frame), ScreenWidth, 0.5)
        if let btn = temBtn {
         contentView.frame = CGRectMake(0, CGRectGetMaxY(line.frame), ScreenWidth, CGRectGetMaxY(btn.frame) + 15)
        }
        layoutFinishBlock!(height: CGRectGetMaxY(contentView.frame))
    }
    
    private func setupUI(){
     addSubview(titleLbl)
     addSubview(line)
     addSubview(contentView)
     setupBtns()
    }
    
    private func setupBtns() {
        let marginX: CGFloat = 15.0
        let marginY: CGFloat = 15.0
        let height:CGFloat = 28.0
        
        for i in 0 ..< btnTitles.count {
            let tagBtn = createBtn()
            let titleStr = btnTitles[i] as NSString
            let width:CGFloat = titleStr.boundingRectWithSize(CGSizeZero, options: NSStringDrawingOptions(rawValue: 0), attributes: [NSFontAttributeName : tagBtn.titleLabel!.font], context: nil).width + 20 * 2
            tagBtn.tag = i
            tagBtn.setTitle(titleStr as String, forState: UIControlState.Normal)
            tagBtn.addTarget(self, action: #selector(SearchHeaderView.clickSearchBtn(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            tagBtn.frame.size.width = width
            tagBtn.frame.size.height = height
            contentView.addSubview(tagBtn)
            
            if temBtn == nil {
                tagBtn.frame.origin.x = marginX
                tagBtn.frame.origin.y = marginY
            } else {
                let isWrap = ScreenWidth - CGRectGetMaxX(temBtn!.frame) - marginX < tagBtn.frame.size.width + marginX;
                if (isWrap) {
                    /// 换行
                    tagBtn.frame.origin.x = marginX;
                    tagBtn.frame.origin.y = CGRectGetMaxY(temBtn!.frame) + marginY;
                } else {
                    /// 不换行
                    tagBtn.frame.origin.x =  CGRectGetMaxX(temBtn!.frame) + marginX;
                    tagBtn.frame.origin.y = temBtn!.frame.origin.y;
                }
            }
            temBtn = tagBtn;
        }
    }
    
    @objc private func clickSearchBtn(sender: UIButton){
            NSNotificationCenter.defaultCenter().postNotificationName("Notif_BtnAction_SearchTag", object: nil)
    }
    
    
    private func createBtn() -> UIButton {
        let tagBtn = UIButton(type: UIButtonType.Custom)
        tagBtn.titleLabel!.font = UIFont.systemFontOfSize(13.0)
        tagBtn.layer.cornerRadius = 3.0
        tagBtn.layer.masksToBounds = true
        tagBtn.layer.borderWidth = 0.5
        tagBtn.layer.borderColor = UIColor(red: 221.0/255.0, green: 221.0/255.0, blue: 221.0/255.0, alpha: 1.0).CGColor
        tagBtn.setTitleColor(UIColor(red: 80.0/255.0, green: 80.0/255.0, blue: 80.0/255.0, alpha: 1.0), forState: UIControlState.Normal)
        return tagBtn
    }
    

    //懒加载
    private lazy var titleLbl:UILabel =  {
      let lab = UILabel()
        lab.text = "    大家都在搜"
        lab.backgroundColor = Color_GlobalBackground
        lab.font = UIFont.systemFontOfSize(13.0)
        lab.textAlignment = NSTextAlignment.Left
        lab.textColor = UIColor(red: 150.0/255.0, green: 150.0/255.0, blue: 153.0/255.0, alpha: 1.0)
        return lab
    }()
    
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 221.0/255.0, green: 221.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        return line
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        return view
    }()
    
}