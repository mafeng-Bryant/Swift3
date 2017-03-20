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
    
    fileprivate func setupUI(){
       isHidden = true
       addSubview(bgImageView)
    
        tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.sectionFooterHeight = 0.0001
        tableView!.sectionHeaderHeight = 0.0001
        tableView!.backgroundView = nil
        tableView?.isScrollEnabled = false
        tableView!.backgroundColor = UIColor.clear
        tableView!.separatorInset = UIEdgeInsets.zero
        tableView!.layoutMargins = UIEdgeInsets.zero
        tableView!.separatorColor = UIColor(red: 120.0/255.0, green: 120.0/255.0, blue: 120.0/255.0, alpha: 1.0)
        tableView!.register(UINib(nibName: "PopoverSortCell", bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)
        tableView!.tableFooterView = UIView()
        addSubview(tableView!)
       //给蒙层绑定事件
        let tap = UITapGestureRecognizer(target: self,action: #selector(PopoverSortView.hiddenPopoerView))
        maskCoverView.addGestureRecognizer(tap)
    }
    
     @objc fileprivate func hiddenPopoerView(){
      maskCoverView.removeFromSuperview()
      hiddenSortView()
    }
    
    fileprivate func  setupFrame(){
      bgImageView.frame = bounds
      tableView?.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    }
    
    fileprivate lazy var maskCoverView: MaskCoverView = MaskCoverView()

    
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
    isHidden = false
    transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
    layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
    layer.position = CGPoint(x: newpositionX, y: newpositionY)
    UIView.animate(withDuration: 0.2, animations: {
        self.transform = CGAffineTransform.identity
    })
    }
    
    internal func hiddenSortView(){
       UIView.animate(withDuration: 0.25, animations: {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 0.000001)
        }, completion: { (finish) in
               self.isHidden = true
        }) 
     }
    
    fileprivate lazy var datas:NSArray = ["默认排序", "按热度排序", "价格从低到高", "价格从高到低"]
    //
    fileprivate lazy var bgImageView:UIImageView = UIImageView(image: UIImage(named: "popover_background_right"))
}

extension PopoverSortView:UITableViewDelegate,UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! PopoverSortCell
        cell.layoutMargins = UIEdgeInsets.zero;
        cell.preservesSuperviewLayoutMargins = false
        cell.textLab.text = datas[indexPath.row] as? String
        cell.selectBtn.isHidden = indexPath.row == selectRow ? false : true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRow = indexPath.row
        tableView.reloadData()
    }

 
}




