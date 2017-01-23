//
//  MOAddToCarViewController.swift
//  DemoCode
//
//  Created by lieon on 2016/11/28.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

private let tagCellID = "MOCornertTagTableViewCell"
private let numCellID = "MOAddNumTableViewCell"
class MOAddToCarViewController: UIViewController {
    lazy var addViewModel: CarViewModel = CarViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBAction func dismiss(_ sender: UIButton) {
         sender.removeFromSuperview()
         dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
}

extension MOAddToCarViewController {
    fileprivate  func setupUI() {
        view.backgroundColor = UIColor.clear
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MOCornertTagTableViewCell", bundle: nil), forCellReuseIdentifier: tagCellID)
        tableView.register(UINib(nibName: "MOAddNumTableViewCell", bundle: nil), forCellReuseIdentifier: numCellID)
    }
    
    fileprivate func loadData() {
        addViewModel.loadGoods {
            self.tableView.reloadData()
        }
    }
}

extension MOAddToCarViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return addViewModel.cate.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
             guard let cell = tableView.dequeueReusableCell(withIdentifier: tagCellID, for: indexPath) as?  MOCornertTagTableViewCell else { return UITableViewCell() }
            cell.model = addViewModel.cate[indexPath.row]
            cell.tapAction = { model in
                
                
            }
            return cell
        } else {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: numCellID, for: indexPath) as?  MOAddNumTableViewCell else { return UITableViewCell() }
            cell.numChangeAction = { num in
                
            }
            return cell
        }
    }
    
}

extension MOAddToCarViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let tempIndexPath = addViewModel.lastSelectedIndexPath {
            if tempIndexPath != indexPath {
                let model = addViewModel.cate[tempIndexPath.row]
                model.isSelected = false
                tableView.reloadRows(at: [tempIndexPath], with: .automatic)
            }
        }
        addViewModel.lastSelectedIndexPath = indexPath
        let model = addViewModel.cate[indexPath.row]
        model.isSelected = true
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
