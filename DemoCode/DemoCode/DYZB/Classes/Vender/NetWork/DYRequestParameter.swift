//
//  DYRequestParameter.swift
//  DemoCode
//
//  Created by lieon on 2016/10/16.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import PromiseKit
import ObjectMapper

class RequestParameter: Model {
    var limit: Int?
    var offset: Int?
    override func mapping(map: Map) {
        limit <- (map["limit"], IntStringTransform())
        offset <- (map["offset"], IntStringTransform())
    }
}

class gameRequestParameter: Model {
    var limit: Int?
    var offset: Int?
    var time: String?
    var client_sys: String = "ios"
    override func mapping(map: Map) {
        limit <- (map["limit"], IntStringTransform())
        offset <- (map["offset"], IntStringTransform())
        time <- map["time"]
        client_sys <- map["client_sys"]
    }
}

class HomeGameParameter: Model {
    var shortName: String?
    
    override func mapping(map: Map) {
        shortName <- map["shortName"]
    }
}

class EntertainmentParameter: Model {
    var time: String?
    
    override func mapping(map: Map) {
        time <- map["time"]
    }
    
}

class FunnyDataParameter: RequestParameter { }

class RoomDataRequestParameter: Model {
    var roomID: String?
    
    override func mapping(map: Map) {
        roomID <- map["room_id"]
    }
}
