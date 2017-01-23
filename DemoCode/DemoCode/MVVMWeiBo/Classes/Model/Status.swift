//
//  Status.swift
//  DemoCode
//
//  Created by lieon on 16/9/18.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import ObjectMapper

class Status: Model {
/*
    "favorited":false,
    "mblogtype":0,
    "attitudes_status":0,
    "created_at":"Wed Sep 09 10:12:55 +0800 2015",
    "id":3885105414216212,
    "mblogid":"CzHYNhGPq",
    "pic_bg":"http://img.t.sinajs.cn/t6/skin/public/feed_cover/vip_009_y.png?version=2015080302",
    "text":"我家这个好忠犬啊～[喵喵] http://t.cn/Ry4UXdF //@我是呆毛芳子蜀黍w:这是什么鬼？ http://t.cn/Ry4U5fQ //@清新可口喵酱圆脸星人是扭蛋狂魔:窝家这个 超委婉的拒绝了窝 http://t.cn/Ry4ylqt //@GloriAries:我家这位好高冷orz http://t.cn/RyUsE79 //@-水蛋蛋-:我的是玩咖即视感 http://t.cn/RyUsS8Q ",
    "idstr":"3885105414216212",
    "source_type":2,
    "geo":null,
    */
    
    var createdTime: String?
    var text: String?
    var user: User?
    var retweetStatus:Status?
    var picURLs: [String]?
    
    override func mapping(map: Map) {
        createdTime <- map["created_at"]
        text <- map["text"]
        user <- map["user"]
        picURLs <- map["picURLs"]
        retweetStatus <- map["retweeted_status"]
    }
}
