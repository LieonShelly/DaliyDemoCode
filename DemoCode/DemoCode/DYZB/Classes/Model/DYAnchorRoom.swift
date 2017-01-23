//
//  DYAnchorRoom.swift
//  DemoCode
//
//  Created by lieon on 2016/11/13.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import ObjectMapper

class DYAnchorRoom: Model {
/**
     "use_p2p":"0",
     "show_details":"东北妹子尛小钰新浪微博@四个小就是尛小钰啊 粉丝q群 528267884 火箭可上房管呦~ 送火箭加q微信好友位滴",
     "nickname":"尛小钰",
     "rtmp_url":"http://hdl3.douyucdn.cn/live",
     "ggad":Object{...},
     "anchor_city":"鱼塘",
     "specific_status":"0",
     "url":"/537428",
     "servers":Array[30],
     "rtmp_cdn":"ws",
     "specific_catalog":"",
     "cate_id1":8,
     "show_status":"1",
     "game_icon_url":"https://staticlive.douyucdn.cn/upload/game_cate/c0c66cb41973d700b120826fd9e9016d.jpg",
     "game_name":"颜值",
     "cdnsWithName":Array[4],
     "show_time":"1479047126",
     "isVertical":1,
     "rtmp_live":"537428r7DkK2nXZz.flv?wsAuth=63b78dfa2977023652b49d6c99d485ae&token=app-ios-77202619-537428-16653233989f544cd1815c12332d3966&logo=0&expire=0",
     "fans":"214009",
     "game_url":"/directory/game/yz",
     "room_src":"http://staticlive.douyucdn.cn/upload/appCovers/2016/11/13/537428_201611131403_small.jpg",
     "is_white_list":"0",
     "room_name":"你知道宝宝在等你吗",
     "owner_uid":"36533415",
     "owner_avatar":"https://apic.douyucdn.cn/upload/avatar/face/201609/05/45a0b5790a05647cdde70357fb29d42b_big.jpg",
     "black":Array[0],
     "vertical_src":"http://staticlive.douyucdn.cn/upload/appCovers/2016/11/13/537428_201611131403_big.jpg",
     "room_dm_delay":90,
     "owner_weight":"12.7t",
     "is_pass_player":0,
     "hls_url":"http://hls3.douyucdn.cn/live/537428r7DkK2nXZz/playlist.m3u8?wsSecret=d910864aa80a71591b32ca266366145c&wsTime=1479049411",
     "room_id":"537428",
     "cur_credit":"12",
     "gift_ver":"0",
     "low_credit":"4",
     "gift":Array[6],
     "rtmp_multi_bitrate":Array[0],
     "cdns":Array[4],
     "online":122184,
     "credit_illegal":"0",
     "vod_quality":"0",
     "cate_id":"201"
     */
    var rtmp_url: URL?
    
    override func mapping(map: Map) {
        rtmp_url <- ( map["rtmp_url"], URLStringTransform())
    }
}
