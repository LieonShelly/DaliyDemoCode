//
//  DYRecomendHeadernReusableView.swift
//  DemoCode
//
//  Created by lieon on 16/9/30.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class DYRecomendHeadernReusableView: UICollectionReusableView {
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var tagIconView: UIImageView!
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBAction func moreButtonClick(_ sender: AnyObject) {
    }
    
    var remmendGroup: DYAnchorGroup? {
        didSet{
            tagLabel.text = remmendGroup?.tagName
        }
    }
    
}
