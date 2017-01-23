//
//  DYEntertainmentViewController.swift
//  DemoCode
//
//  Created by lieon on 2016/10/10.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class DYEntertainmentViewController: DYBaseCollectionViewController {
    fileprivate lazy var entertainentViewModel: DYEntertainmentViewModel = DYEntertainmentViewModel()
    fileprivate lazy var menuView: DYMenuView = {
        let view = DYMenuView.menuView()
        return view
    }()

    override func setupUI() {
        super.setupUI()
        collectionView.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0)
        menuView.frame = CGRect(x: 0, y: -200, width: collectionView.bounds.width, height: 200)
        collectionView.addSubview(menuView)
        
    }
    
    override func loadData() {
        super.loadData()
        self.requestData()
    }
}

extension DYEntertainmentViewController {
    fileprivate func requestData() {
        entertainentViewModel.loadAllEntertainmentData {[unowned self] in
            self.loadDataFinished()
            self.baseViewModel = self.entertainentViewModel
            self.menuView.groups = self.entertainentViewModel.menuDatas
            self.collectionView.reloadData()
            
        }
    }
}

extension DYEntertainmentViewController {
     override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: normaItemW, height: normalitemH)
    }
}

