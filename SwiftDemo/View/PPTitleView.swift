//
//  PPTitleView.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/29.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

protocol PPTitleViewDelegate:NSObjectProtocol {
    func clickIndex(index: NSInteger)
}

class PPTitleView: UIView {
   
    weak var delegate:PPTitleViewDelegate?
    private var singleBtn:UIButton?
    private var strategyBtn:UIButton?
    private let lineMargin:CGFloat = 10.0

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
    
    private func setupFrame(){
      strategyBtn?.frame = CGRectMake(0, 0, frame.width*0.5, frame.height)
      singleBtn?.frame = CGRectMake(CGRectGetMaxX(strategyBtn!.frame), 0, frame.width*0.5, frame.height)
      line.frame = CGRectMake(lineMargin*0.5, frame.height - 6, frame.width*0.5 - lineMargin, 2.0)
    }
   
    private func  setupUI(){
      backgroundColor = UIColor.clearColor()
      singleBtn = createBtn("单品")
      singleBtn?.addTarget(self, action: #selector(PPTitleView.singleBtnAction), forControlEvents: UIControlEvents.TouchUpInside)
      strategyBtn = createBtn("攻略")
      strategyBtn?.addTarget(self, action: #selector(PPTitleView.strategyBtnAction), forControlEvents: UIControlEvents.TouchUpInside)
     addSubview(strategyBtn!)
     addSubview(singleBtn!)
     addSubview(line)
    }
    
    @objc private func strategyBtnAction(){
       if let delegate =  delegate {
          delegate.clickIndex(0)
        }
    }
    
    @objc private func singleBtnAction(){
        if let delegate = delegate {
            delegate.clickIndex(1)
        }
    }
    
    //public method
    func scrollLine(scrollViewWidth: CGFloat, offsetX: CGFloat){
        self.line.frame.origin.x =  self.lineMargin * 0.5 + offsetX / scrollViewWidth * (bounds.width - self.line.bounds.width - self.lineMargin)
    }
    
    // MARK: - 懒加载
    lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        return view
    }()
    
    private func createBtn(titile: NSString) -> UIButton {
        let btn = UIButton(type: UIButtonType.Custom)
        btn.setTitle(titile as String, forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(15.0)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        return btn
    }
    
}
