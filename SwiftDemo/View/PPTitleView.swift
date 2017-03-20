//
//  PPTitleView.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/29.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

protocol PPTitleViewDelegate:NSObjectProtocol {
    func clickIndex(_ index: NSInteger)
}

class PPTitleView: UIView {
   
    weak var delegate:PPTitleViewDelegate?
    fileprivate var singleBtn:UIButton?
    fileprivate var strategyBtn:UIButton?
    fileprivate let lineMargin:CGFloat = 10.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()
        setupFrame()
    }
    
    fileprivate func setupFrame(){
      strategyBtn?.frame = CGRect(x: 0, y: 0, width: frame.width*0.5, height: frame.height)
      singleBtn?.frame = CGRect(x: strategyBtn!.frame.maxX, y: 0, width: frame.width*0.5, height: frame.height)
      line.frame = CGRect(x: lineMargin*0.5, y: frame.height - 6, width: frame.width*0.5 - lineMargin, height: 2.0)
    }
   
    fileprivate func  setupUI(){
      backgroundColor = UIColor.clear
      singleBtn = createBtn("单品")
      singleBtn?.addTarget(self, action: #selector(PPTitleView.singleBtnAction), for: UIControlEvents.touchUpInside)
      strategyBtn = createBtn("攻略")
      strategyBtn?.addTarget(self, action: #selector(PPTitleView.strategyBtnAction), for: UIControlEvents.touchUpInside)
     addSubview(strategyBtn!)
     addSubview(singleBtn!)
     addSubview(line)
    }
    
    @objc fileprivate func strategyBtnAction(){
       if let delegate =  delegate {
          delegate.clickIndex(0)
        }
    }
    
    @objc fileprivate func singleBtnAction(){
        if let delegate = delegate {
            delegate.clickIndex(1)
        }
    }
    
    //public method
    func scrollLine(_ scrollViewWidth: CGFloat, offsetX: CGFloat){
        self.line.frame.origin.x =  self.lineMargin * 0.5 + offsetX / scrollViewWidth * (bounds.width - self.line.bounds.width - self.lineMargin)
    }
    
    // MARK: - 懒加载
    lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    fileprivate func createBtn(_ titile: NSString) -> UIButton {
        let btn = UIButton(type: UIButtonType.custom)
        btn.setTitle(titile as String, for: UIControlState())
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        btn.setTitleColor(UIColor.white, for: UIControlState())
        return btn
    }
    
}
