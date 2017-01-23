//
//  DYGameHeaderView.swift
//  DemoCode
//
//  Created by lieon on 2016/10/10.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import SnapKit

private let gameameHeaderViewgameCellID = "gameameHeaderViewgameCellID"
class DYGameHeaderView: UIView {
    var games:[DYGame]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = []
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "DYGameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: gameameHeaderViewgameCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let layout = collectionView.collectionViewLayout  as? UICollectionViewFlowLayout else { return  }
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 70, height: collectionView.bounds.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
    }
}

extension DYGameHeaderView {
    class func  headerView() -> DYGameHeaderView {
        guard  let view =   Bundle.main.loadNibNamed("DYGameHeaderView", owner: nil, options: nil),
            let cycleView = view.first as? DYGameHeaderView  else {
                return DYGameHeaderView()
        }
        return cycleView
    }
}

extension DYGameHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:gameameHeaderViewgameCellID , for: indexPath) as? DYGameCollectionViewCell else { return UICollectionViewCell() }
        cell.game = games?[indexPath.item]
        return cell
    }
}

