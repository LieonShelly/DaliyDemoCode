//
//  User.swift
//  DemoCode
//
//  Created by lieon on 16/9/18.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import ObjectMapper

class User: Model {
/**
     avatar_large":"http://tp2.sinaimg.cn/1656022165/180/5717829893/0",
     "profile_image_url":"http://tp2.sinaimg.cn/1656022165/50/5717829893/0",
     "allow_all_act_msg":false,
     "id":1656022165,
     "cover_image":"http://ww1.sinaimg.cn/crop.0.0.920.300/62b4e495gw1etuikppjj7j20pk08c7a8.jpg",
     "remark":"",
     "verified_trade":"",
     "level":7,
     "verified":false,
     */
    var avatarLarge: String?
    var profileImageUrl: String?
    var id: Int = 0
    var coverImage: String?
    var level: Int = 1
    var verified: Bool = false
    var screenName: String?
    
    override func mapping(map: Map) {
        avatarLarge <- map["avatar_large"]
        profileImageUrl <- map["profile_image_url"]
        id <- map["id"]
        coverImage <- map["cover_image"]
        level <- (map["level"], IntStringTransform())
        verified <- (map["verified"], BoolStringTransform())
        screenName <- map["screen_name"]
    }
    
}
