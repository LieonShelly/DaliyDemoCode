//
//  CHRefreshView.swift
//  DemoCode
//
//  Created by lieon on 16/9/26.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

/// 负责刷新的显示和动画效果
/**
 iOS中UIView的旋转动画
   - 默认为顺时针
   - 就近原则
   - 要实现同方向的旋转要调整一个非常小的数字
 */
class CHRefreshView: UIView {
    @IBOutlet weak var pullArrow: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var loadingView: UIImageView!
    var state: RefrehState = .normal {
        didSet {
            switch state {
            case .normal:
                textLabel.text = "继续使劲拉"
                pullArrow.isHidden = false
                loadingView.isHidden = true
                UIView.animate(withDuration: 0.25, animations: {
                    self.pullArrow.transform = CGAffineTransform.identity
                })
            case .pulling:
                textLabel.text = "放手就刷新"
                UIView.animate(withDuration: 0.25, animations: {
                    self.pullArrow.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI - 0.0001))
                })
            case .wilRefresh:
                textLabel.text = "正在刷新中..."
                loadingView.isHidden = false
                pullArrow.isHidden = true
            }
        }
    }
    
    class func refreView() -> CHRefreshView {
        let nib = UINib(nibName: "CHRefreshView", bundle: nil)
         guard let view = nib.instantiate(withOwner: nil, options: nil)[0] as? CHRefreshView else { return CHRefreshView() }
        return view
    }
}
