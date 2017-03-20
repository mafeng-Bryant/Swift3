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
    var layoutFinishBlock: ((_ height: CGFloat) ->())?
    
    init(layoutFinish: @escaping (_ height: CGFloat) ->()) {
        super.init(frame: CGRect.zero)
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
    fileprivate func setupFrame(){
    titleLbl.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 30.0)
    line.frame = CGRect(x: 0, y: titleLbl.frame.maxY, width: ScreenWidth, height: 0.5)
        if let btn = temBtn {
         contentView.frame = CGRect(x: 0, y: line.frame.maxY, width: ScreenWidth, height: btn.frame.maxY + 15)
        }
        layoutFinishBlock!(contentView.frame.maxY)
    }
    
    fileprivate func setupUI(){
     addSubview(titleLbl)
     addSubview(line)
     addSubview(contentView)
     setupBtns()
    }
    
    fileprivate func setupBtns() {
        let marginX: CGFloat = 15.0
        let marginY: CGFloat = 15.0
        let height:CGFloat = 28.0
        
        for i in 0 ..< btnTitles.count {
            let tagBtn = createBtn()
            let titleStr = btnTitles[i] as NSString
            let width:CGFloat = titleStr.boundingRect(with: CGSize.zero, options: NSStringDrawingOptions(rawValue: 0), attributes: [NSFontAttributeName : tagBtn.titleLabel!.font], context: nil).width + 20 * 2
            tagBtn.tag = i
            tagBtn.setTitle(titleStr as String, for: UIControlState())
            tagBtn.addTarget(self, action: #selector(SearchHeaderView.clickSearchBtn(_:)), for: UIControlEvents.touchUpInside)
            tagBtn.frame.size.width = width
            tagBtn.frame.size.height = height
            contentView.addSubview(tagBtn)
            
            if temBtn == nil {
                tagBtn.frame.origin.x = marginX
                tagBtn.frame.origin.y = marginY
            } else {
                let isWrap = ScreenWidth - temBtn!.frame.maxX - marginX < tagBtn.frame.size.width + marginX;
                if (isWrap) {
                    /// 换行
                    tagBtn.frame.origin.x = marginX;
                    tagBtn.frame.origin.y = temBtn!.frame.maxY + marginY;
                } else {
                    /// 不换行
                    tagBtn.frame.origin.x =  temBtn!.frame.maxX + marginX;
                    tagBtn.frame.origin.y = temBtn!.frame.origin.y;
                }
            }
            temBtn = tagBtn;
        }
    }
    
    @objc fileprivate func clickSearchBtn(_ sender: UIButton){
            NotificationCenter.default.post(name: Notification.Name(rawValue: "Notif_BtnAction_SearchTag"), object: nil)
    }
    
    
    fileprivate func createBtn() -> UIButton {
        let tagBtn = UIButton(type: UIButtonType.custom)
        tagBtn.titleLabel!.font = UIFont.systemFont(ofSize: 13.0)
        tagBtn.layer.cornerRadius = 3.0
        tagBtn.layer.masksToBounds = true
        tagBtn.layer.borderWidth = 0.5
        tagBtn.layer.borderColor = UIColor(red: 221.0/255.0, green: 221.0/255.0, blue: 221.0/255.0, alpha: 1.0).cgColor
        tagBtn.setTitleColor(UIColor(red: 80.0/255.0, green: 80.0/255.0, blue: 80.0/255.0, alpha: 1.0), for: UIControlState())
        return tagBtn
    }
    

    //懒加载
    fileprivate lazy var titleLbl:UILabel =  {
      let lab = UILabel()
        lab.text = "    大家都在搜"
        lab.backgroundColor = Color_GlobalBackground
        lab.font = UIFont.systemFont(ofSize: 13.0)
        lab.textAlignment = NSTextAlignment.left
        lab.textColor = UIColor(red: 150.0/255.0, green: 150.0/255.0, blue: 153.0/255.0, alpha: 1.0)
        return lab
    }()
    
    fileprivate lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 221.0/255.0, green: 221.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        return line
    }()

    fileprivate lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
}
