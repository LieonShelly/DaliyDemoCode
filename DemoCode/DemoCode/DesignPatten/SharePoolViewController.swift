//
//  SharePoolViewController.swift
//  DemoCode
//
//  Created by lieon on 2016/12/26.
//  Copyright © 2016年 lieon. All rights reserved.
//  享元设计模式
/***
 在界面上随机显示10万朵小花，这些小花只有6种样式
 使用享元模式:
 本来的对象占用的内存比较大，比如UIImageView
 数量非常多(以万为单位)
 每个对象都非常相似，才可以分离出享元
 */

import UIKit

private let totalTypeNumber: Int = 6
enum FlowerType: Int {
    case anemone = 0
    case cosmos
    case gerberas
    case hollyhock
    case jasmine
    case zinnia
}

class SharePoolViewController: UIViewController, UITableViewDataSource {
    fileprivate lazy var tableView: UITableView = {
        let tab = UITableView()
        tab.dataSource = self
        return tab
    }()
  fileprivate lazy var list = [UIImageView]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        tableView.frame = view.frame
        view.addSubview(tableView)
       // 使用享元模式
        let factory = FlowerFactory()
        
        for i in 0 ..< 100000 {
            
                let flowerType = FlowerType(rawValue: Int(arc4random()) % totalTypeNumber)
                let imageView = factory.flowerView(type: flowerType!)
                list.append(imageView)
            print(i)
        
        }
        tableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "id")
        let imageView = list[indexPath.row]
        imageView.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
        cell.contentView.addSubview(list[indexPath.row])
        return cell
    }
}




class FlowerFactory: NSObject {
    
   lazy fileprivate var flowerPool: [FlowerType: UIImageView] = [FlowerType: UIImageView]()
    func flowerView(type: FlowerType ) -> UIImageView {
        if let flowerView = flowerPool[type] {
            return flowerView
        } else {
            let flowerImage: UIImage?
            switch type {
            case .anemone:
                flowerImage = UIImage(named: "anemone.png")
            case .cosmos:
                flowerImage = UIImage(named: "cosmos.png")
            case .gerberas:
                flowerImage = UIImage(named: "gerberas.png")
            case .hollyhock:
                flowerImage = UIImage(named: "hollyhock.png")
            case .jasmine:
                flowerImage = UIImage(named: "jasmine.png")
            case .zinnia:
                flowerImage = UIImage(named: "zinnia.png")
            }
            let flowerView = UIImageView(image: flowerImage)
            flowerPool[type] = flowerView
            return flowerView
        }
        
    }
}
