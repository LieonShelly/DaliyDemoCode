//
//  DYFunnyViewController.swift
//  DemoCode
//
//  Created by lieon on 2016/10/16.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class DYFunnyViewController: DYBaseCollectionViewController {
    lazy var funnyViewModel = DYFunnyViewModel()
    
    override func setupUI() {
        super.setupUI()
        guard  let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.sectionInset = UIEdgeInsets(top: 8, left: 10, bottom: 0, right: 10 )
        layout.headerReferenceSize = CGSize()
    }
    
    override func loadData() {
        baseViewModel = funnyViewModel
        funnyViewModel.loadFunnyData { [unowned self] in
            self.loadDataFinished()
            self.collectionView.reloadData()
        }
    }
}
