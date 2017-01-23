//
//  MOGoods.swift
//  DemoCode
//
//  Created by lieon on 2016/11/28.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class MOGoods: NSObject {
    var imageURL:URL?
    var price: String?
    var stockNum: String?
    var cateStr: [CateModel] = [CateModel]()
    
    
}

class CateModel: NSObject {
    var value: String?
    var isSelected: Bool = false
}
