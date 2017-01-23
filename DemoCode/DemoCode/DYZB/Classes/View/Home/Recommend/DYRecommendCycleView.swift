//
//  DYRecommendCycleView.swift
//  DemoCode
//
//  Created by lieon on 16/10/2.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

private let cellID = "cellID"

class DYRecommendCycleView: UIView {
    var cycleModels: [DYCycle]? {
        didSet {
            collectionView.reloadData()
            pageControl.numberOfPages = cycleModels?.count ?? 0
            let indexPath = IndexPath(item: ((cycleModels?.count) ?? 0) * 100, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            removeTimer()
            addTimer()
        }
    }
    fileprivate var cycleTimer: Timer?
    @IBOutlet weak fileprivate var pageControl: UIPageControl!
    @IBOutlet weak fileprivate var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = [ ]
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "DYCollectionViewCycleCell", bundle: nil), forCellWithReuseIdentifier: cellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let layout = collectionView.collectionViewLayout  as? UICollectionViewFlowLayout else { return  }
        layout.scrollDirection = .horizontal
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
    }
}

extension DYRecommendCycleView {
    class func  cycleView() -> DYRecommendCycleView {
        guard  let view =   Bundle.main.loadNibNamed("DYRecommendCycleView", owner: nil, options: nil),
        let cycleView = view.first as? DYRecommendCycleView  else {
            return DYRecommendCycleView()
        }
        return cycleView
    }
}

extension DYRecommendCycleView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as? DYCollectionViewCycleCell else {
              return UICollectionViewCell()
        }
        let num = indexPath.item % (cycleModels?.count ?? 1)
        cell.cycleModel = cycleModels?[num]
        return cell
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.x + collectionView.bounds.width * 0.5
        let currentPage = Int(contentOffsetX / collectionView.bounds.width)
        pageControl.currentPage = currentPage % (cycleModels?.count ?? 1)

    }
}

extension DYRecommendCycleView {
    fileprivate func addTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(cycleTimerAtion), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    
    fileprivate func removeTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc  private  func cycleTimerAtion() {
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = collectionView.bounds.width + currentOffsetX
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
