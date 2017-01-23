//
//  StatusNormalCell.swift
//  DemoCode
//
//  Created by lieon on 16/9/18.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import Kingfisher

class StatusNormalCell: UITableViewCell, Resource {
    /// 设置为可选是为这个cell要对应两个XIB，其中有一个xib中没有picView这个问view
    @IBOutlet weak var picView: PictureView?
    
    @IBOutlet weak var picViewTopCons: NSLayoutConstraint!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var vipImageView: UIImageView!
    @IBOutlet weak var levelImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var statusViewModel: StatusViewModel? {
        didSet {
            statusLabel.text = statusViewModel?.text
            avatarImageView.kf.setImage(with: downloadURL, placeholder: nil, options: nil, progressBlock: nil) { (image, _, _, _) in
                 self.avatarImageView.image = image?.corner(imageSize: self.avatarImageView.bounds.size)
            }
            picView?.picURLs = statusViewModel?.picURLs
    
       }
    }
    
    var downloadURL: URL {
        let url = NSURL(string: (statusViewModel?.status?.user?.profileImageUrl!)!)!
        return url as URL
    }
    
    var cacheKey: String {
        return ""
    }
    
    override func awakeFromNib() {
        // 开启离屏渲染 - 异步绘制
        self.layer.drawsAsynchronously = true
        // 栅格化 - 异步绘制后会生成一张独立的图片，cell在屏幕上滑动本质是滑动的这张图片，停止滚动后可以监听cell的点击
        self.layer.shouldRasterize = true
        // 使用栅格化必须指定分辨率
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
