//
//  DYAnchor.swift
//  DemoCode
//
//  Created by lieon on 16/10/1.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import ObjectMapper

class DYAnchor: Model {
    var specific_catalog:String?
    var vertical_src: String?
    var  owner_uid: String?
    var ranktype: String?
    var nickname: String?
    var room_src: String?
    var cate_id: String?
    var specific_status: String?
    var game_name: String?
    var online: Int?
    var avatar_small: String?
    var avatar_mid: String?
    var  vod_quality: String?
    var room_name: String?
    var child_id: String?
    var room_id: String?
    var show_time: String?
    var isVertical: Bool = false
    var show_status: String?
    var show_type: String?
    var anchor_city: String?
    
    
    override func mapping(map: Map) {
        specific_catalog <- map["specific_catalog"]
        vertical_src <- map["vertical_src"]
        owner_uid <- map["owner_uid"]
        ranktype <- map["ranktype"]
        nickname <- map["nickname"]
        room_src <- map["room_src"]
        cate_id <- map["cate_id"]
        specific_status <- map["specific_status"]
        avatar_small <- map["avatar_small"]
        online <- map["online"]
        avatar_mid <- map["avatar_mid"]
        vod_quality <- map["vod_quality"]
        room_name <- map["room_name"]
        child_id <- map["child_id"]
        room_id <- map["room_id"]
        show_time <- map["show_time"]
        isVertical <- map["isVertical"]
        show_status <- map["show_status"]
        show_type <- map["show_type"]
        anchor_city <- map["anchor_city"]
    }
    
    
    
    
    
    
    
    
    
    
    
    

    
    
    
    
    
    
}
