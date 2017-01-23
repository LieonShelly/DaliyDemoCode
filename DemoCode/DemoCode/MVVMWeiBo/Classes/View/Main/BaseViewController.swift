//
//  BaseViewController.swift
//  DemoCode
//
//  Created by lieon on 16/9/13.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    
    lazy var tableView: UITableView = {
        let tab = UITableView()
        return tab
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.randomColor()
         setupUI()
    }

    private  func setupUI() {
        tableView.frame = view.bounds
        view.addSubview(tableView)
        automaticallyAdjustsScrollViewInsets = false
        tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: tabBarController?.tabBar.bounds.height ?? 49, right: 0)
    }
}
