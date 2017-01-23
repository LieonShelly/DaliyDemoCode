//
//  DYMenuView.swift
//  DemoCode
//
//  Created by lieon on 2016/10/11.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

private let cellID = "cellID"

class DYMenuView: UIView {
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    var groups: [DYGame]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        autoresizingMask = []
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.register(UINib(nibName: "DYMenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let layout = collectionView.collectionViewLayout  as? UICollectionViewFlowLayout else { return  }
        layout.scrollDirection = .horizontal
        let margin: CGFloat = 0
        let itemWith: CGFloat = collectionView.bounds.width
        let itemHeight: CGFloat = collectionView.bounds.height
        layout.itemSize = CGSize(width:itemWith, height: itemHeight)
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
    }
}

extension DYMenuView {
    class func menuView() -> DYMenuView {
        guard  let view = Bundle.main.loadNibNamed("DYMenuView", owner: nil, options: nil)?.first, let menuView = view as? DYMenuView else {
            return DYMenuView()
        }
        return menuView
    }
}

extension DYMenuView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil { return 0 }
        let pageNum = (groups!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? DYMenuCollectionViewCell else { return UICollectionViewCell() }
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    private func setupCellDataWithCell(cell : DYMenuCollectionViewCell, indexPath : IndexPath) {
        // 0页: 0 ~ 7
        // 1页: 8 ~ 15
        // 2也: 16 ~ 23
        // 1.取出起始位置&终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        // 2.判断越界问题
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        // 3.取出数据,并且赋值给cell
        cell.games = Array(groups![startIndex...endIndex])
    }
}

extension DYMenuView: UICollectionViewDelegateFlowLayout {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 加上collectionView.bounds.width * 0.5是为了在滑动到一半的时候就显示下一页
        let offsetX = scrollView.contentOffset.x + collectionView.bounds.width * 0.5
        let num = offsetX / collectionView.bounds.width
        pageControl.currentPage = Int(num)
    }
}
