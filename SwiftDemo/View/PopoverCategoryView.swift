//
//  PopoverCategoryView.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/22.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

protocol PopoverCategoryViewDelegate:NSObjectProtocol {
    func clickChanelIndex(_ index: NSInteger)
}

class PopoverCategoryView: UIView {

    weak var delegate :PopoverCategoryViewDelegate?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var choseChannelBtn: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var chanelLbl: UILabel!
    /// 缓存滚动分类按钮
    var cacheScrollCategoryBtns = [UIButton]()
    
    /// 当前所选的滚动分类按钮
    var selectedScrollCategoryBtn:UIButton?
    
    /// 缓存格子分类按钮
    var cacheSquareCategoryBtns = [UIButton]()
    //当前选择的分类按钮
    var selectCategoryBtn:UIButton?
    //当前选择格子的分类按钮
    var selectSquareCategoryBtn:UIButton?
    //分类视图
    var popoverView:UIView?
    //弹出按钮的列数
    let popoverBtnColumn = 4
    // 是否显示格子分类视图
    var showingPopoverView = false

    
    class func popoverCategoryView() ->PopoverCategoryView{
        let view = Bundle.main.loadNibNamed("PopoverCategoryView", owner: nil, options: nil)?.last as! PopoverCategoryView
        return view
    }
    
    override func awakeFromNib() {
      setUp()
    }
    
    override func layoutSubviews() {
       super.layoutSubviews()
        setUpFrame()
    }
    
     /// 分类标题
    var categoryTitles:[NSString]? {
        didSet {
          createCategoryBtn(categoryTitles!)
          //弹出分类视图
          popoverView = createPopoverView(categoryTitles!)
        }
    }
    
     fileprivate func createPopoverView(_ titles:[NSString]) ->UIView {
      let btnWidth = ScreenWidth/CGFloat(popoverBtnColumn)
      let btnHeight:CGFloat = 50.0
      let popoverView = UIView()
        for i in 0..<titles.count {
         let title = titles[i]
            let column = i % popoverBtnColumn;
            let row = i / popoverBtnColumn
            let x = btnWidth * CGFloat(column)
            let y = btnHeight * CGFloat(row)
            let btn = createBtn(title);
            btn.tag = i
            btn.frame = CGRect(x: x, y: y, width: btnWidth, height: btnHeight)
            btn.addTarget(self, action: #selector(PopoverCategoryView.squareCategoryBtnAction(_:)), for: UIControlEvents.touchUpInside)
           popoverView.addSubview(btn)
           cacheSquareCategoryBtns.append(btn)
          //线条
            btn.addSubview(createLine(CGRect(x: btn.bounds.width - 0.5, y: 0, width: 0.5, height: btn.bounds.height)))
            btn.addSubview(createLine(CGRect(x: 0, y: btn.bounds.height - 0.5, width: btn.bounds.width, height: 0.5)))
            if i == 0 { squareCategoryBtnAction(btn)}
        }
        popoverView.addSubview(squareBottomLineView)
        popoverView.backgroundColor = UIColor.white
        popoverView.frame = CGRect(x: 0, y: -cacheSquareCategoryBtns.last!.frame.maxY, width: ScreenWidth, height: cacheSquareCategoryBtns.last!.frame.maxY)
        return popoverView
    }

    
    @objc fileprivate func squareCategoryBtnAction(_ sender: UIButton) {
        if let btn = selectSquareCategoryBtn {
            btn.isSelected = false
        }
        sender.isSelected = !sender.isSelected
        selectSquareCategoryBtn = sender
        squareBottomLineView.frame = CGRect(x: sender.frame.origin.x, y: sender.frame.maxY - 2.0, width: sender.frame.width, height: 2.0)
        if self.showingPopoverView {
            hiddenPopoverView()
        }
    }
    
    fileprivate func createLine(_ frame: CGRect) ->UIView{
        let view = UIView(frame: frame)
        view.backgroundColor = Color_GlobalLine
        return view
    }
    
    func scrollCategoryBtnByIndex(_ index: NSInteger){
      scrollCategoryAction(cacheScrollCategoryBtns[index])
    }
    
    
    fileprivate func showPopoverView(){
    backgroundColor = backView.backgroundColor
    choseChannelBtn.isSelected = true
    backView.isHidden = false
        
    squareCategoryBtnAction(cacheSquareCategoryBtns[selectCategoryBtn!.tag])
 
    //显示蒙版
    showMaskView()
    superview!.insertSubview(popoverView!, belowSubview: self)
    backView.alpha = 0
     UIView.animate(withDuration: 0.3, animations: {
        self.backView.alpha = 1.0
        self.popoverView!.frame.origin.y = self.bounds.height
        }, completion: { (finished) in
            self.showingPopoverView = true
        }) 
    }
    
    fileprivate func showMaskView(){
    superview?.insertSubview(maskCoverView, belowSubview: self)
    }
    
    @objc fileprivate func hiddenPopoverView() {
     backgroundColor = UIColor.white
     choseChannelBtn.isSelected = false
     backView.isHidden = true
     backView.alpha = 1.0
    
     //代理出去，让外面视图知道滚动到哪一个位置
     scrollCategoryAction(cacheScrollCategoryBtns[selectSquareCategoryBtn!.tag])
        
     UIView.animate(withDuration: 0.3, animations: {
    self.backView.alpha = 0
    self.popoverView!.frame.origin.y = -self.popoverView!.bounds.height
    }, completion: { (_) in
        self.popoverView!.removeFromSuperview()
        self.showingPopoverView = false
   }) 
        maskCoverView.removeFromSuperview()
   }
    
    @IBAction func showPopoverView(_ sender: UIButton) {
        if !sender.isSelected {
           showPopoverView()
        }else {
           hiddenPopoverView()
        }
    }
    
    fileprivate func createCategoryBtn(_ titles: [NSString]){
        for i in 0..<titles.count {
            let title = titles[i]
            let btn = createBtn(title)
            let width:CGFloat = title.boundingRect(with: CGSize.zero, options: NSStringDrawingOptions(rawValue: 0), attributes: [NSFontAttributeName: btn.titleLabel!.font], context: nil).width +  20
            let orginx:CGFloat = (cacheScrollCategoryBtns.last == nil) ? 5:cacheScrollCategoryBtns.last!.frame.maxX
            btn.frame = CGRect(x: orginx, y: 0, width: width, height: 43)
            btn.tag = i
            btn.addTarget(self, action: #selector(PopoverCategoryView.scrollCategoryAction), for: UIControlEvents.touchUpInside)
            cacheScrollCategoryBtns.append(btn)
            scrollView.addSubview(btn)
            if i==0 {
                scrollCategoryAction(btn)
            }
         }
     }
    
    fileprivate func setUpFrame(){
 
      //scrollview contentsize
      if let lastCategoryBtn = cacheScrollCategoryBtns.last {
         scrollView.contentSize = CGSize(width: lastCategoryBtn.frame.maxX, height: 0)
      }
        scrollBottomLineView.frame = CGRect(x: selectCategoryBtn!.frame.origin.x, y: self.bounds.height - 2.0, width: selectCategoryBtn!.frame.size.width - 10, height: 2.0)
        scrollBottomLineView.center.x = selectCategoryBtn!.center.x
    }
    
    //private method
    fileprivate func createBtn(_ title: NSString) ->UIButton {
        let btn = UIButton()
        btn.setTitle(title as String, for: UIControlState())
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        btn.setTitleColor(UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0), for: UIControlState())
        btn.setTitleColor(UIColor(red: 251.0/255.0, green: 45.0/255.0, blue: 71.0/255.0, alpha: 1.0), for: UIControlState.selected)
        return btn
    }
    
   
    //event response
    @objc fileprivate func scrollCategoryAction(_ sender: UIButton) {
        if let btn = selectCategoryBtn  { btn.isSelected = false }
         sender.isSelected = !sender.isSelected
         selectCategoryBtn = sender
        /// 重设分类标签状态
        if sender.center.x < bounds.width * 0.5 {
            scrollView.setContentOffset(CGPoint.zero, animated: true)
        } else if scrollView.contentSize.width > bounds.width && sender.center.x > bounds.width * 0.5 && sender.center.x < (scrollView.contentSize.width - bounds.width * 0.5) {
            scrollView.setContentOffset(CGPoint(x: sender.frame.origin.x + sender.bounds.width * 0.5 - bounds.width * 0.5, y: 0), animated: true)
        } else {
            scrollView.setContentOffset(CGPoint(x: max(scrollView.contentSize.width - scrollView.bounds.size.width, 0), y: 0), animated: true)
        }
        setNeedsLayout()
       delegate?.clickChanelIndex(sender.tag)
    }
    
    //初始化方法
    fileprivate func setUp(){
        backgroundColor = UIColor.white
        backView.isHidden = true
        scrollView.isScrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(scrollBottomLineView)
        chanelLbl.textColor = UIColor.red
        let tap = UITapGestureRecognizer(target: self, action:#selector(PopoverCategoryView.hiddenPopoverView))
        maskCoverView.addGestureRecognizer(tap)
   }

    //mark 懒加载
    fileprivate var scrollBottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 251.0/255.0, green: 45.0/255.0, blue: 71.0/255.0, alpha: 1.0)
        return view
    }()
    
    fileprivate lazy var maskCoverView: MaskCoverView = MaskCoverView()
    
    fileprivate var squareBottomLineView:UIView = {
     let view = UIView()
     view.backgroundColor = UIColor(red: 251.0/255.0, green: 45.0/255.0, blue: 71.0/255.0, alpha: 1.0)
     return view
    }()

    
}
