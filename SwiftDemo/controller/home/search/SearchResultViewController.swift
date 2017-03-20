//
//  SearchResultViewController.swift
//  Liwushuo
//
//  Created by hans on 16/7/4.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var redLineView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var redLineViewConstraintLeading: NSLayoutConstraint!

    
    override func loadView() {
     let classString = String(describing: type(of: self))
     Bundle.main.loadNibNamed(classString, owner: self, options: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupFrame()
    }
    
    fileprivate func setupUI(){
    view.backgroundColor = Color_GlobalBackground
    navigationItem.titleView = searchBar
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        
    
    }
    
    
    fileprivate func setupFrame(){
    
        
    
    }
    
   
    @objc fileprivate func leftBtnAction(){
    
    
    
    }
   
    
    @objc fileprivate func rightBtnAction(){
        
    
        
    }
    
    
    fileprivate lazy var leftBtn: UIButton = UIButton(backTarget: self, action: #selector(SearchResultViewController.leftBtnAction))
    
    fileprivate lazy var rightBtn: UIButton = UIButton(sortTarget: self, action: #selector(SearchResultViewController.rightBtnAction))
    
    
    
    // MARK: - 懒加载
    fileprivate lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "快选一份礼物，送给亲爱的Ta吧"
        searchBar.tintColor = UIColor.white
        searchBar.backgroundImage = UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default)
        return searchBar
    }()
    
}




extension SearchResultViewController:UISearchBarDelegate {

 
    
 
}





