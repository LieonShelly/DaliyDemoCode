//
//  HomeViewController.swift
//  DemoCode
//
//  Created by lieon on 16/9/13.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import PromiseKit


private let cellID = "normalCellID"
class HomeViewController: BaseViewController,UITableViewDelegate {
    internal var isPullup: Bool = false
    internal var statusViewModelArray: [StatusViewModel]?
    private var refreshControl: CHRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
      _ = requestLocalStatus().then { (statusViewModelArray) -> Void in
        self.statusViewModelArray = statusViewModelArray
        self.tableView.reloadData()
        }
        loadData()
    }
    
    private  func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isEditing = true
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        tableView.register(UINib(nibName: "StatusNormalCell", bundle: nil), forCellReuseIdentifier: cellID)
        refreshControl = CHRefreshControl()
        tableView.addSubview(refreshControl ?? UIRefreshControl())
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }

   @objc private func loadData() {
        refreshControl?.beginRefresh()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
//            if self.isPullup {
//                print("正在上拉")
//            } else {
//                print("下拉刷新")
//            }
//            self.isPullup = false
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row  = indexPath.row
        let section = tableView.numberOfSections - 1
        let count = tableView.numberOfRows(inSection: section)
        if section < 0 || row < 0 {
            return
        }
        // 在最后一行并且没有发生上拉时添加上拉刷新
        if row == count - 1 && !isPullup {
            isPullup = true
            loadData()
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         guard let viewModelArray = statusViewModelArray else { return 0 }
        return viewModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? StatusNormalCell else {
               return UITableViewCell()
              }
        cell.statusViewModel = statusViewModelArray?[indexPath.row]
        return cell
    }
    
    @objc(tableView:editingStyleForRowAtIndexPath:) func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.init(rawValue: UITableViewCellEditingStyle.delete.rawValue | UITableViewCellEditingStyle.insert.rawValue)!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
   
    
    
}
