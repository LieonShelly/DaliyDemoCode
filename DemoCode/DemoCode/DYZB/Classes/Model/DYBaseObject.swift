//
//  DYBaseObject.swift
//  DemoCode
//
//  Created by lieon on 16/10/1.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import ObjectMapper

class DYBaseObject<T: Mappable>: Mappable {
    var error: Int = 0
    var data: [T]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        error <- (map["error"], IntStringTransform())
        data <- map["data"]
    }
}

class DYSingleBaseObject<T: Mappable>: Mappable {
    var error: Int = 0
    var data: T?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        error <- (map["error"], IntStringTransform())
        data <- map["data"]
    }
}

/// 游戏
class gameAnchors: DYBaseObject<DYAnchorGroup> { }

/// 颜值
class prettyAnchors: DYBaseObject<DYAnchor> { }

/// 最新
class latestAnchors: DYBaseObject<DYAnchor> { }

/// 轮播
class cycleModel: DYBaseObject<DYCycle> { }

/// 游戏
class gameModel: DYBaseObject<DYGame> { }


