//
//  DYBaseCollectionViewController.swift
//  DemoCode
//
//  Created by lieon on 2016/10/11.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

private let normalCellID = "normalCellID"
private let prettyCellID = "prettyCellID"
private let sectionHeaderID = "sectionHeaderID"
private let interMargin: CGFloat = 10
private let sectionHeaderHeight: CGFloat = 50
let normaItemW = (UIScreen.width() - 3 * interMargin) * 0.5
let normalitemH = normaItemW * 0.75
private let prettyIremW = (UIScreen.width() - 3 * interMargin) * 0.5
private let prettyItemH = prettyIremW * 4 / 3
class DYBaseCollectionViewController: DYBaseViewController {
     lazy var baseViewModel = DYBaseViewModel()
     lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        let width =  (UIScreen.width() - 3 * interMargin) * 0.5
        let height = width * 0.75
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.headerReferenceSize = CGSize(width: UIScreen.width(), height: sectionHeaderHeight)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: normalCellID)
        collectionView.register(UINib(nibName: "DYRecomendHeadernReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionHeaderID)
        collectionView.register(UINib(nibName: "DYCollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: normalCellID)
        collectionView.register(UINib(nibName: "DYCollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: prettyCellID)
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        return collectionView
        }()
    
    override func viewDidLoad() {
        contentView = collectionView
        super.viewDidLoad()
        setupUI()
        loadData()
    }

}

extension DYBaseCollectionViewController {
     func setupUI() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.white
    }
    
    func loadData() {
        
    }
}
extension DYBaseCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseViewModel.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group =  baseViewModel.anchorGroups[section]
        return group.roomList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let group = baseViewModel.anchorGroups[indexPath.section]
        let roomList = group.roomList
        if indexPath.section  == 1 {
            guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: prettyCellID, for: indexPath) as? DYCollectionViewPrettyCell else { return UICollectionViewCell() }
            cell.anchorModel = roomList?[indexPath.item]
            return cell
        } else {
            guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: normalCellID, for: indexPath) as? DYCollectionViewNormalCell else { return UICollectionViewCell() }
            cell.anchorModel = roomList?[indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionHeaderID, for: indexPath) as? DYRecomendHeadernReusableView else { return UICollectionReusableView()}
        headerView.remmendGroup = baseViewModel.anchorGroups[indexPath.section]
        return headerView
        
    }

}

extension DYBaseCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: prettyIremW, height: prettyItemH)
        } else {
            return CGSize(width: normaItemW, height: normalitemH)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let anchor = baseViewModel.anchorGroups[indexPath.section].roomList?[indexPath.item] else { return }
        anchor.isVertical == true ? showRoomVC(anchor: anchor): pushRoomVC(anchor: anchor)
        
    }
    
    fileprivate  func showRoomVC(anchor: DYAnchor) {
        
        let destVC = DYShowRoomViewController()
        destVC.anchor = anchor
        present(destVC, animated: true, completion: nil)
    }
    
    fileprivate  func pushRoomVC(anchor: DYAnchor) {
        
        navigationController?.pushViewController(DYRoomNormalViewController(), animated: true)
    }
}
