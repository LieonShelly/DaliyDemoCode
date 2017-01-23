//
//  DYAnchorGroup.swift
//  DemoCode
//
//  Created by lieon on 16/10/1.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import ObjectMapper

/**
 "tag_name":"英雄联盟",
 "tag_id":1,
 "icon_url":"https://staticlive.douyucdn.cn/upload/game_cate/f0a531a7198cac2ba0747c435644d690.jpg",
 "small_icon_url":"",
 "push_vertical_screen":"0"
 
 */
class DYAnchorGroup: Model {
    var roomList:[DYAnchor]?
    var tagName: String?
    var iconUrl: String?
    
    override func mapping(map: Map) {
        roomList <- map["room_list"]
        tagName <- map["tag_name"]
        iconUrl <- map["icon_url"]
    }
    
    
}
