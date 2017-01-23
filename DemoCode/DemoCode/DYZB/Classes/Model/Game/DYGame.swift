//
//  DYGame.swift
//  DemoCode
//
//  Created by lieon on 2016/10/9.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import ObjectMapper

class DYGame: Model {
    var tag_name: String?
    var icon_url: String?
    
    override func mapping(map: Map) {
        tag_name <- map["tag_name"]
        icon_url <- map["icon_url"]
    }
    
}
