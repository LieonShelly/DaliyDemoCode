//
//  DYCollectionViewPrettyCell.swift
//  DemoCode
//
//  Created by lieon on 16/9/30.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import Kingfisher

class DYCollectionViewPrettyCell: DYCollectionViewBaseCell {
    @IBOutlet weak var roomSrcImageView: UIImageView!
    @IBOutlet weak var roomLabel: UIButton!
    @IBOutlet weak var onlineLabel: UIButton!
    @IBOutlet weak var nickLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UIButton!
    
    var anchorModel: DYAnchor? {
        didSet {
             guard let num = anchorModel?.online else { return  }
            let onlinStr = num > 10000 ? "\(num / 10000)万人在线" : "\(num)人在线"
            onlineLabel.setTitle(onlinStr, for: .normal)
            nickLabel.text = anchorModel?.nickname
            cityLabel.setTitle(anchorModel?.anchor_city, for: .normal)
            let url = URL(string: anchorModel?.vertical_src ?? "")!
            roomSrcImageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (image, _, _, _) in
                guard   let cornerIv = image?.corner(imageSize: self.roomSrcImageView.bounds.size) else { return }
                self.roomSrcImageView.image = cornerIv
            }
        }
    }

}
