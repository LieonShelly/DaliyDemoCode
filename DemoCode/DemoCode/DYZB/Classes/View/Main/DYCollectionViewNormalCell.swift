//
//  DYCollectionViewNormalCell.swift
//  DemoCode
//
//  Created by lieon on 16/9/30.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import Kingfisher

class DYCollectionViewNormalCell: DYCollectionViewBaseCell {
    @IBOutlet weak var roomSrcImgeView: UIImageView!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var onineLabel: UIButton!
    @IBOutlet weak var nickLabel: UIButton!
    var anchorModel: DYAnchor? {
        didSet {
            roomLabel.text = anchorModel?.room_name
            nickLabel.setTitle(anchorModel?.nickname, for: .normal)
            
            guard let num = anchorModel?.online else { return  }
            let onlinStr = num > 10000 ? "\(num / 10000)万人在线" : "\(num)人在线"
            onineLabel.setTitle(onlinStr, for: .normal)
             guard let url = URL(string: anchorModel?.vertical_src ?? "") else { return  }
            roomSrcImgeView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (image, _, _, _) in
                guard   let cornerIv = image?.corner(imageSize: self.roomSrcImgeView.bounds.size) else { return }
                self.roomSrcImgeView.image = cornerIv
            }
            
        }
    }
    
}
