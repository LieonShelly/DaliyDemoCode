//
//  PViewController.swift
//  DemoCode
//
//  Created by lieon on 2016/12/28.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class PViewController: UIViewController {
   fileprivate lazy  var data: PDemoDataModel = PDemoDataModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var evePatetrn: UISwitch! {
        didSet {
            evePatetrn.isOn = UserConfig.bool(forKey: .isEve)
        }
    }
}

extension PViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PTableViewCell.self, forCellReuseIdentifier: "PTableViewCell")
    }
}

extension PViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.mixedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PTableViewCell = tableView.dequeueReusebleCell(forIndexPath: indexPath)
        switch data.mixedArray[indexPath.row]  {
        case .event(let event):
        cell.get(data: event)
        case .festival(let festival):
            cell.get(data: festival)
        }
        return cell
    }
}

extension PViewController: SegueHandlerType {
    typealias SegueIdentifier = SegueID
    enum SegueID: String {
        case mix
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch sgueIdentifier(for: segue) {
        case .mix:
        print("mix")
        }
    }
}

