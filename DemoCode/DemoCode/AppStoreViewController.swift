//
//  AppStoreViewController.swift
//  DemoCode
//
//  Created by lieon on 2017/1/20.
//  Copyright © 2017年 lieon. All rights reserved.
//  App Store首页、知乎发现也的头部在下拉的时候是不动的，上推得时候会和列表一起无视差上滑动。

import UIKit
import LRefresh

class AppStoreViewController: UIViewController {

    fileprivate lazy var tableView: UITableView = {
        let tab = UITableView(frame: self.view.bounds, style: .plain)
        tab.delegate = self
        tab.dataSource = self
        tab.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tab
    }()

    fileprivate lazy var header: UIView = {
        let header = UIView()
        header.backgroundColor = UIColor.red
        return header
    }()

    fileprivate lazy var refresh: LRefreshControl = {
        let refresh = LRefreshControl()
        return refresh
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        automaticallyAdjustsScrollViewInsets = false
         tableView.contentInset = UIEdgeInsets(top: 140, left: 0, bottom: 0, right: 0)
        view.addSubview(tableView)
        header.frame =  CGRect(x: 0, y: 64, width: tableView.bounds.width, height: 140)
        view.addSubview(header)
        tableView.addSubview(refresh)
        refresh.refreshHandler = {
            
        }
    }

}

extension AppStoreViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
extension AppStoreViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        print("\(header.frame.origin.y),\(y)")
        if y > -204 {
            header.frame.origin.y = 64 - y - 204
        } else {
            header.frame.origin.y = 64
        }
//        header.frame.origin.y = 64 - 64 - 140 - max(y, -204)
    }
}
