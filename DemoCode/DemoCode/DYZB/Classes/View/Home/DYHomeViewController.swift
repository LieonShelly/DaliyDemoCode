//
//  DYHomeViewController.swift
//  DemoCode
//
//  Created by lieon on 16/9/29.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class DYHomeViewController: UIViewController {
    private lazy var pageTitleView: DYPageTitleView = {
        let pvc = DYPageTitleView(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: 44), titles: ["推荐", "游戏", "娱乐", "趣玩"])
        return pvc
    }()
    private lazy var pageContenView: DYPageContenView  = { [unowned self] in
        var childVCs = [UIViewController]()
        let recommendVC = DYRecommendViewController()
        let gameVC = DYHomeGameViewController()
        let entertainmentVC = DYEntertainmentViewController()
        childVCs.append(recommendVC)
        childVCs.append(gameVC)
        childVCs.append(entertainmentVC)
        childVCs.append(DYFunnyViewController())
        let pageContenView = DYPageContenView(frame: CGRect(x: 0, y: 64 + self.pageTitleView.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64 - 44 - 44), childVCs: childVCs, parentVC: self)
        return pageContenView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tapAction()
    }
   
    private  func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(pageTitleView)
        view.addSubview(pageContenView)
    }
    
    private  func tapAction() {

        pageTitleView.titleTapAction = {[weak self] seletedIndex in
            self?.pageContenView.selected(index: seletedIndex)
        }
        pageContenView.tapAction = {[weak self] (progress, souceIndex, targetIndex) in
            self?.pageTitleView.setTitle(progress: progress, sourceIndex: souceIndex, targetIndex: targetIndex)
        }
    }
}
