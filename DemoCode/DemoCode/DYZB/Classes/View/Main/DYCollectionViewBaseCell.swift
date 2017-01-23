//
//  DYCollectionViewBaseCell.swift
//  DemoCode
//
//  Created by lieon on 16/10/4.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class DYCollectionViewBaseCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.drawsAsynchronously = true
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
