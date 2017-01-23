//
//  DYRecommendViewController.swift
//  DemoCode
//
//  Created by lieon on 16/9/30.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

private let cycleViewH = UIScreen.width() * 3 / 8
private let gameViewH: CGFloat = 90

class DYRecommendViewController: DYBaseCollectionViewController {
   
    fileprivate lazy var recommendViewModel = DYRecommendViewModel()
    fileprivate lazy var cycleView: DYRecommendCycleView = {
        let cycle = DYRecommendCycleView.cycleView()
        return cycle
    }()
    fileprivate lazy var gameView: DYGameView = {
        let view = DYGameView.gameView()
        return view
    }()
    fileprivate lazy var playButton: UIButton = {
        let btn = UIButton(normalImage: "column_selected", selectedImage: "column_selected")
        btn.addTarget(self, action: #selector(palyAction), for: .touchUpInside)
        return btn
    }()
    
    override func setupUI() {
        super.setupUI()
        collectionView.contentInset = UIEdgeInsets(top: cycleViewH + gameViewH, left: 0, bottom: 0, right: 0)
        cycleView.frame = CGRect(x: 0, y: -(cycleViewH + gameViewH), width: collectionView.bounds.size.width, height: cycleViewH)
        collectionView.addSubview(cycleView)
        gameView.frame = CGRect(x: 0, y: cycleView.frame.maxY, width: collectionView.bounds.size.width, height: gameViewH)
        collectionView.addSubview(gameView)
        view.insertSubview(playButton, aboveSubview: collectionView)
        playButton.snp.makeConstraints { (maker) in
            maker.right.equalTo(-20)
            maker.centerY.equalTo(view.snp.centerY).offset(50)
            maker.size.equalTo(CGSize(width: 50, height: 50))
        }
    }
    
    override func loadData() {
        super.loadData()
        self.requestData()
    }
}

extension DYRecommendViewController {
    fileprivate func requestData() {
        recommendViewModel.requestData { [unowned self] in
            self.loadDataFinished()
            self.baseViewModel = self.recommendViewModel
            self.collectionView.reloadData()
            self.gameView.gameGroups = self.recommendViewModel.gameGroups
        }
        recommendViewModel.requestCycleData { [unowned self] in
            self.cycleView.cycleModels = self.recommendViewModel.cycleModels
        }
    }
    
    @objc fileprivate  func palyAction() {
        let  playVC = UIStoryboard(name: "DYHome", bundle: nil).instantiateViewController(withIdentifier: "DYPlayViewController")
        navigationController?.pushViewController(playVC, animated: true)
        
    }
}
