//
//  DYGameCollectionViewCell.swift
//  DemoCode
//
//  Created by lieon on 16/10/2.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import Kingfisher

class DYGameCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var gameGroup: DYAnchorGroup? {
        didSet{
            tagLabel.text = gameGroup?.tagName
            if let iconStr = gameGroup?.iconUrl  {
               guard let url = URL(string:iconStr) else { return  }
                imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "home_more_btn"), options: nil, progressBlock: nil) { (image, _, _, _) in
                    guard let iv = image?.cycle(imageSize: self.imageView.bounds.size) else { return  }
                     self.imageView.image = iv
                }
            } else {
                imageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
    
    var game: DYGame? {
        didSet {
            tagLabel.text = game?.tag_name
            if  let url = URL(string: game?.icon_url ?? "") {
                imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "home_more_btn"), options: nil, progressBlock: nil, completionHandler: { (image, _, _, _) in
                    guard let iv = image?.cycle(imageSize: CGSize(width: 45, height: 45)) else { return  }
                    self.imageView.image = iv
                })
            }
        }
    }
    
}
