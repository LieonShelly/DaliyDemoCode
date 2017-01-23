//
//  DYBaseViewController.swift
//  DemoCode
//
//  Created by lieon on 2016/10/16.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class DYBaseViewController: UIViewController {

    var contentView: UIView?
    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "dyla_img_loading_1"))
        imageView.animationImages = [#imageLiteral(resourceName: "dyla_img_loading_1"),#imageLiteral(resourceName: "dyla_img_loading_2")]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(imageView)
        imageView.startAnimating()
        imageView.center = view.center
        contentView?.isHidden = true
    }

    func loadDataFinished() {
        contentView?.isHidden = false
        imageView.stopAnimating()
        imageView.isHidden = false
    }
}
