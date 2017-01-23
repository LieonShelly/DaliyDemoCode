//
//  DYCycle.swift
//  DemoCode
//
//  Created by lieon on 16/10/2.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import ObjectMapper

class DYCycle: Model {
    var id: Int = 0
    var title: String?
    var pic_url: String?
    var tv_pic_url: String?
    var room:  DYAnchor?
    
    override func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        pic_url <- map["pic_url"]
        tv_pic_url <- map["tv_pic_url"]
        room <- map["room"]
    }
    

}
