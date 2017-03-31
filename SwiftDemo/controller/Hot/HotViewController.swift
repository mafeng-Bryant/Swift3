//
//  HotViewController.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/22.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

public enum Type: String {
    case overlayVertical = "overlayVertical"
    case overlayHorizontal = "overlayHorizontal"
    case bottomToTop = "bottomToTop"
    case topToBottom = "topToBottom"
    case leftToRight = "leftToRight"
    case rightToLeft = "rightToLeft"
}

class HotViewController: PPBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "广告";
        self.view.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }

    fileprivate lazy var tableView: UITableView = {
       let tableView = UITableView(frame:self.view.frame,style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var data: [Type] = [
    .bottomToTop,
    .topToBottom,
    .leftToRight,
    .rightToLeft,
    .overlayVertical,
    .overlayHorizontal
    ]

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HotViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
}

extension HotViewController: UITableViewDelegate {
    var adDate: Date? {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return f.date(from: "2016-10-21 12:45:41")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = data[indexPath.row].rawValue
        print(adDate ?? "2323")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
//        let controller = ADController(type: data[indexPath.row])
//        _ = controller.isCanShowing(date: adDate!)
//        controller.images = (0 ... 9).flatMap { UIImage(named: "IMG_\($0).PNG") }
//        controller.isShowPageControl = true
//        controller.isAllowLooping = true
//        controller.selectedHandel = { (idx, controller) in
//            print(idx)
//            controller.dismiss(animated: true, completion: nil)
//        }
//        //        if !flag {
//        //            present(controller, animated: true) {}
//        //        }
//        present(controller, animated: true) {}
    }
}







