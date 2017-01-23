//
//  DYCollectionViewCycleCell.swift
//  DemoCode
//
//  Created by lieon on 16/10/2.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import Kingfisher

class DYCollectionViewCycleCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var cycleModel: DYCycle? {
        didSet {
            guard let url = URL(string:cycleModel?.pic_url ?? "") else { return  }
            imageView.kf.setImage(with: url)
        }
    }
    
}
