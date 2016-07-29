//
//  PopoverSortView.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/28.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit


private let cellIdentifier = "PopoverSortCell"

class PopoverSortView: UIView {
    
    var tableView:UITableView?
    var selectRow:NSInteger = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupFrame()
    }
    
    private func setupUI(){
       hidden = true
       addSubview(bgImageView)
    
        tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.sectionFooterHeight = 0.0001
        tableView!.sectionHeaderHeight = 0.0001
        tableView!.backgroundView = nil
        tableView?.scrollEnabled = false
        tableView!.backgroundColor = UIColor.clearColor()
        tableView!.separatorInset = UIEdgeInsetsZero
        tableView!.layoutMargins = UIEdgeInsetsZero
        tableView!.separatorColor = UIColor(red: 120.0/255.0, green: 120.0/255.0, blue: 120.0/255.0, alpha: 1.0)
        tableView!.registerNib(UINib(nibName: "PopoverSortCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: cellIdentifier)
        tableView!.tableFooterView = UIView()
        addSubview(tableView!)
       //给蒙层绑定事件
        let tap = UITapGestureRecognizer(target: self,action: #selector(PopoverSortView.hiddenPopoerView))
        maskCoverView.addGestureRecognizer(tap)
    }
    
     @objc private func hiddenPopoerView(){
      maskCoverView.removeFromSuperview()
      hiddenSortView()
    }
    
    private func  setupFrame(){
      bgImageView.frame = bounds
      tableView?.frame = CGRectMake(0, 0, bounds.width, bounds.height)
    }
    
    private lazy var maskCoverView: MaskCoverView = MaskCoverView()

    
   internal func showSortView(){
    
    //蒙层
    maskCoverView.backgroundColor = UIColor(white: 0,alpha: 0.1)
    superview?.insertSubview(maskCoverView, belowSubview: self)
    
    
    // 更改anchorPoint后，position(frame)会改变
    let oldposition = layer.position
    let oldanchorPoint = layer.anchorPoint
    let newanchorPoint = CGPoint(x: 0.5, y: 0.0)
    let newpositionX = oldposition.x + (newanchorPoint.x - oldanchorPoint.x)  * bounds.size.width
    let newpositionY = oldposition.y + (newanchorPoint.y - oldanchorPoint.y)  * bounds.size.height
    hidden = false
    transform = CGAffineTransformMakeScale(1.0, 0.0)
    layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
    layer.position = CGPoint(x: newpositionX, y: newpositionY)
    UIView.animateWithDuration(0.2, animations: {
        self.transform = CGAffineTransformIdentity
    })
    }
    
    internal func hiddenSortView(){
       UIView.animateWithDuration(0.25, animations: {
            self.transform = CGAffineTransformMakeScale(1.0, 0.000001)
        }) { (finish) in
               self.hidden = true
        }
     }
    
    private lazy var datas:NSArray = ["默认排序", "按热度排序", "价格从低到高", "价格从高到低"]
    //
    private lazy var bgImageView:UIImageView = UIImageView(image: UIImage(named: "popover_background_right"))
}

extension PopoverSortView:UITableViewDelegate,UITableViewDataSource {
  
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! PopoverSortCell
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = false
        cell.textLab.text = datas[indexPath.row] as? String
        cell.selectBtn.hidden = indexPath.row == selectRow ? false : true
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectRow = indexPath.row
        tableView.reloadData()
    }

 
}




