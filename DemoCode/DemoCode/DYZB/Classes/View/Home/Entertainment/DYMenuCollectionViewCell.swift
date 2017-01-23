//
//  DYMenuCollectionViewCell.swift
//  DemoCode
//
//  Created by lieon on 2016/10/11.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

private let gameCellID = "gameCell"
class DYMenuCollectionViewCell: UICollectionViewCell {
    var games: [DYGame]? {
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
        let itemWidth = collectionView.bounds.width / 4
        let itemHeight = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
    }
}

extension DYMenuCollectionViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCellID, for: indexPath) as? DYGameCollectionViewCell else { return UICollectionViewCell() }
        cell.game = games?[indexPath.item]
        cell.clipsToBounds = true
        return cell
    }
}
