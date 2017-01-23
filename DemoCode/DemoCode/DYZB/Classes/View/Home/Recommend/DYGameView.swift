//
//  DYGameView.swift
//  DemoCode
//
//  Created by lieon on 16/10/2.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

private let gameCellID = "gameCell"
class DYGameView: UIView {
    var gameGroups: [DYAnchorGroup]? {
        didSet{
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = []
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "DYGameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: gameCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let layout = collectionView.collectionViewLayout  as? UICollectionViewFlowLayout else { return  }
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 70, height: bounds.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
    }
}

extension DYGameView {
    class func  gameView() -> DYGameView {
        guard  let view =   Bundle.main.loadNibNamed("DYGameView", owner: nil, options: nil),
            let cycleView = view.first as? DYGameView  else {
                return DYGameView()
        }
        return cycleView
    }
}

extension DYGameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameGroups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCellID, for: indexPath) as? DYGameCollectionViewCell else { return UICollectionViewCell() }
        cell.gameGroup = gameGroups?[indexPath.item]
        return cell
    }
}

