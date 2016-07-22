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

    /// 缓存滚动分类按钮
    var cacheScrollCategoryBtns = [UIButton]()
    //当前选择的分类按钮
    var selectCategoryBtn:UIButton?
    
    
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
 
        }
    }
    
    private func createCategoryBtn(titles: [NSString]){
        for i in 0..<titles.count {
          let title = titles[i]
          let btn = createBtn(title)
          btn.tag = i
          let width:CGFloat = title.boundingRectWithSize(CGSizeZero, options: NSStringDrawingOptions(rawValue: 0), attributes: [NSFontAttributeName: btn.titleLabel!.font], context: nil).width +  20
          let orginx:CGFloat = (cacheScrollCategoryBtns.last == nil) ? 5:CGRectGetMaxX(cacheScrollCategoryBtns.last!.frame)
          btn.frame = CGRectMake(orginx, 0, width, 43)
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
       setNeedsLayout()
       delegate?.clickChanelIndex(sender.tag)
    }
    
    //初始化方法
    private func setUp(){
        backgroundColor = UIColor.whiteColor()
        backView.backgroundColor = UIColor.clearColor()
        backView.hidden = true
        scrollView.scrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(scrollBottomLineView)
   }

    //mark 懒加载
    private var scrollBottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 251.0/255.0, green: 45.0/255.0, blue: 71.0/255.0, alpha: 1.0)
        return view
    }()
    
}
