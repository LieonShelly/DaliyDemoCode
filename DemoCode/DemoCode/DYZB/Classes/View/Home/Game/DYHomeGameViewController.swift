//
//  DYHomeGameViewController.swift
//  DemoCode
//
//  Created by lieon on 2016/10/9.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

private let itemMargin: CGFloat = 10
private let itemWidth: CGFloat =  (UIScreen.width() - itemMargin * 2) / 3
private let itemHeight: CGFloat = itemWidth
private let headerWidth: CGFloat = UIScreen.width()
private let headerHeight: CGFloat = 60
private let cellID = "cellID"
private let headerID = "headerID"

class DYHomeGameViewController: DYBaseViewController {

    fileprivate lazy var gameViewModel: DYGameViewModel = DYGameViewModel()
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.sectionInset = UIEdgeInsets(top: 0, left: itemMargin, bottom: 0, right: itemMargin)
        layout.headerReferenceSize = CGSize(width: headerWidth, height: headerHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "DYGameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        collectionView.register(UINib(nibName: "DYRecomendHeadernReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
        return collectionView
    }()
    fileprivate lazy var headerView: DYGameHeaderView = {
        let headerView = DYGameHeaderView.headerView()
        return headerView
    }()

    override func viewDidLoad() {
        contentView = collectionView
        super.viewDidLoad()
        setupUI()
        requestData()
    }
}

extension DYHomeGameViewController {
    
    fileprivate func setupUI() {
        collectionView.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (maker) in
            maker.left.equalTo(0)
            maker.right.equalTo(0)
            maker.top.equalTo(0)
            maker.bottom.equalTo(0)
        }
        collectionView.contentInset = UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 0)
        headerView.frame = CGRect(x: 0, y: -120, width: view.bounds.width, height: 120)
        collectionView.addSubview(headerView)
        print(collectionView.frame,headerView.frame)
        
    }
    
    fileprivate func requestData() {
        gameViewModel.loadAllGameData { [unowned self] in
            self.loadDataFinished()
            self.collectionView.reloadData()
            self.headerView.games = self.gameViewModel.commonGames
        }
    }
}

extension DYHomeGameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameViewModel.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? DYGameCollectionViewCell else {
           return UICollectionViewCell()
        }
        let game = gameViewModel.games[indexPath.item]
        cell.game = game
        return cell
    }
}

extension DYHomeGameViewController: UICollectionViewDelegate {
    @objc(collectionView:viewForSupplementaryElementOfKind:atIndexPath:) func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID, for: indexPath) as?DYRecomendHeadernReusableView else {  return  UICollectionReusableView() }
        view.tagLabel.text = "全部"
        view.tagIconView.image = #imageLiteral(resourceName: "Img_orange")
        view.moreButton.isHidden = true
        return view
        
    }
}
