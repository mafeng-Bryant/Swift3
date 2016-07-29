//
//  ClassfiyViewController.swift
//  SwiftDemo
//
//  Created by patpat on 16/7/22.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

class ClassfiyViewController: PPBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         setupUI()
    }

    override func viewWillAppear(animated: Bool) {
       super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      setupFrame()
    }
    
    private func setupUI(){
    automaticallyAdjustsScrollViewInsets = false
    view.backgroundColor = Color_GlobalBackground
    navigationItem.titleView = UIView()
    navigationItem.rightBarButtonItem = UIBarButtonItem(chooseGifTarget: self, action: #selector(ClassfiyViewController.searchGifBtnAction))

        
    }
    
    @objc private func searchGifBtnAction(){
    
        
        
     
        
        
    }
    
    
    
    
    private lazy var titleView:UIView = UIView()
    
    
    
    
    
    
    
    private func setupFrame(){
    
    
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
