//
//  PopoverCategoryView.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/22.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

protocol PopoverCategoryViewDelegate:NSObjectProtocol {
    func clickChanelIndex(index: NSInteger)
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
        let view = NSBundle.mainBundle().loadNibNamed("PopoverCategoryView", owner: nil, options: nil).last as! PopoverCategoryView
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
    
     private func createPopoverView(titles:[NSString]) ->UIView {
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
            btn.frame = CGRectMake(x, y, btnWidth, btnHeight)
            btn.addTarget(self, action: #selector(PopoverCategoryView.squareCategoryBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
           popoverView.addSubview(btn)
           cacheSquareCategoryBtns.append(btn)
          //线条
            btn.addSubview(createLine(CGRectMake(btn.bounds.width - 0.5, 0, 0.5, btn.bounds.height)))
            btn.addSubview(createLine(CGRectMake(0, btn.bounds.height - 0.5, btn.bounds.width, 0.5)))
            if i == 0 { squareCategoryBtnAction(btn)}
        }
        popoverView.addSubview(squareBottomLineView)
        popoverView.backgroundColor = UIColor.whiteColor()
        popoverView.frame = CGRectMake(0, -CGRectGetMaxY(cacheSquareCategoryBtns.last!.frame), ScreenWidth, CGRectGetMaxY(cacheSquareCategoryBtns.last!.frame))
        return popoverView
    }

    
    @objc private func squareCategoryBtnAction(sender: UIButton) {
        if let btn = selectSquareCategoryBtn {
            btn.selected = false
        }
        sender.selected = !sender.selected
        selectSquareCategoryBtn = sender
        squareBottomLineView.frame = CGRectMake(sender.frame.origin.x, CGRectGetMaxY(sender.frame) - 2.0, sender.frame.width, 2.0)
        if self.showingPopoverView {
            hiddenPopoverView()
        }
    }
    
    private func createLine(frame: CGRect) ->UIView{
        let view = UIView(frame: frame)
        view.backgroundColor = Color_GlobalLine
        return view
    }
    
    
    private func showPopoverView(){
    backgroundColor = backView.backgroundColor
    choseChannelBtn.selected = true
    backView.hidden = false
        
    squareCategoryBtnAction(cacheSquareCategoryBtns[selectCategoryBtn!.tag])
 
        
    //显示蒙版
    showMaskView()
    superview!.insertSubview(popoverView!, belowSubview: self)
    backView.alpha = 0
     UIView.animateWithDuration(0.3, animations: {
        self.backView.alpha = 1.0
        self.popoverView!.frame.origin.y = self.bounds.height
        }) { (finished) in
            self.showingPopoverView = true
        }
    }
    
    private func showMaskView(){
    superview?.insertSubview(maskCoverView, belowSubview: self)
    }
    
    @objc private func hiddenPopoverView() {
     backgroundColor = UIColor.whiteColor()
     choseChannelBtn.selected = false
     backView.hidden = true
     backView.alpha = 1.0
    
     //代理出去，让外面视图知道滚动到哪一个位置
     scrollCategoryAction(cacheScrollCategoryBtns[selectSquareCategoryBtn!.tag])
        
     UIView.animateWithDuration(0.3, animations: {
    self.backView.alpha = 0
    self.popoverView!.frame.origin.y = -self.popoverView!.bounds.height
    }) { (_) in
        self.popoverView!.removeFromSuperview()
        self.showingPopoverView = false
   }
        maskCoverView.removeFromSuperview()
   }
    
    @IBAction func showPopoverView(sender: UIButton) {
        if !sender.selected {
           showPopoverView()
        }else {
           hiddenPopoverView()
        }
    }
    
    private func createCategoryBtn(titles: [NSString]){
        for i in 0..<titles.count {
            let title = titles[i]
            let btn = createBtn(title)
            let width:CGFloat = title.boundingRectWithSize(CGSizeZero, options: NSStringDrawingOptions(rawValue: 0), attributes: [NSFontAttributeName: btn.titleLabel!.font], context: nil).width +  20
            let orginx:CGFloat = (cacheScrollCategoryBtns.last == nil) ? 5:CGRectGetMaxX(cacheScrollCategoryBtns.last!.frame)
            btn.frame = CGRectMake(orginx, 0, width, 43)
            btn.tag = i
            btn.addTarget(self, action: #selector(PopoverCategoryView.scrollCategoryAction), forControlEvents: UIControlEvents.TouchUpInside)
            cacheScrollCategoryBtns.append(btn)
            scrollView.addSubview(btn)
            if i==0 {
                scrollCategoryAction(btn)
            }
         }
     }
    
    private func setUpFrame(){
 
      //scrollview contentsize
      if let lastCategoryBtn = cacheScrollCategoryBtns.last {
         scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastCategoryBtn.frame), 0)
      }
        scrollBottomLineView.frame = CGRectMake(selectCategoryBtn!.frame.origin.x, self.bounds.height - 2.0, selectCategoryBtn!.frame.size.width - 10, 2.0)
        scrollBottomLineView.center.x = selectCategoryBtn!.center.x
    }
    
    //private method
    private func createBtn(title: NSString) ->UIButton {
        let btn = UIButton()
        btn.setTitle(title as String, forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(13.0)
        btn.setTitleColor(UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor(red: 251.0/255.0, green: 45.0/255.0, blue: 71.0/255.0, alpha: 1.0), forState: UIControlState.Selected)
        return btn
    }
    
   
    //event response
    @objc private func scrollCategoryAction(sender: UIButton) {
        if let btn = selectCategoryBtn  { btn.selected = false }
         sender.selected = !sender.selected
         selectCategoryBtn = sender
        /// 重设分类标签状态
        if sender.center.x < bounds.width * 0.5 {
            scrollView.setContentOffset(CGPointZero, animated: true)
        } else if scrollView.contentSize.width > bounds.width && sender.center.x > bounds.width * 0.5 && sender.center.x < (scrollView.contentSize.width - bounds.width * 0.5) {
            scrollView.setContentOffset(CGPointMake(sender.frame.origin.x + sender.bounds.width * 0.5 - bounds.width * 0.5, 0), animated: true)
        } else {
            scrollView.setContentOffset(CGPointMake(max(scrollView.contentSize.width - scrollView.bounds.size.width, 0), 0), animated: true)
        }
        setNeedsLayout()
       delegate?.clickChanelIndex(sender.tag)
    }
    
    //初始化方法
    private func setUp(){
        backgroundColor = UIColor.whiteColor()
        backView.hidden = true
        scrollView.scrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(scrollBottomLineView)
        chanelLbl.textColor = UIColor.redColor()
        let tap = UITapGestureRecognizer(target: self, action:#selector(PopoverCategoryView.hiddenPopoverView))
        maskCoverView.addGestureRecognizer(tap)
   }

    //mark 懒加载
    private var scrollBottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 251.0/255.0, green: 45.0/255.0, blue: 71.0/255.0, alpha: 1.0)
        return view
    }()
    
    private lazy var maskCoverView: MaskCoverView = MaskCoverView()
    
    private var squareBottomLineView:UIView = {
     let view = UIView()
     view.backgroundColor = UIColor(red: 251.0/255.0, green: 45.0/255.0, blue: 71.0/255.0, alpha: 1.0)
     return view
    }()

    
}
