//
//  StatusViewModel.swift
//  DemoCode
//
//  Created by lieon on 16/9/18.
//  Copyright © 2016年 lieon. All rights reserved.
//

/// 系统刷新控件存在的问题
/***
   如果用户不放手，下拉到一定程度就会刷新，会浪费用户流量
   如果程序主动调用 beginRefreshing 不会显示菊花 Xcode8才出现的
   自定义刷新控件，最重要的是解决用户松手后才刷新
 */
import UIKit
import Kingfisher

class StatusViewModel {
    var status: Status?
    var text: String?
    var pictureViewSize: CGSize = CGSize()
    var picURLs: [String]? {
        return status?.retweetStatus?.picURLs ?? status?.picURLs
    }
    var retweetText: String?
    var rowHeiht: CGFloat = 0.0
    init(model: Status) {
        self.status = model
        self.text = model.text
        retweetText = "@" + (model.user?.screenName ?? "") + ":" + (model.retweetStatus?.text ?? "")
        updateRowHeight()
    }
    
    func updateSingleImageSize(image: UIImage) {
        var size = image.size
        let maxWidth: CGFloat = 300
        /// 过宽的图像处理
        if size.width > maxWidth {
            size.width = maxWidth
            size.height = size.width * image.size.height/image.size.width
        }
       /// 过窄图像的处理
        let minWidth: CGFloat = 40
        if size.width < minWidth {
            size.width = minWidth
            size.height = size.width * image.size.height / image.size.width / 4
        }
        
        pictureViewSize = size
        
    }
    
    func updateRowHeight() {
        
    }
    
}

extension StatusViewModel: CustomDebugStringConvertible {
    
    var debugDescription: String {
        var str = "\n"
        let properties = Mirror(reflecting: self).children
        for c in properties {
            if let name = c.label {
                str += name + ": \(c.value)\n"
            }
        }
        return str
    }
}

