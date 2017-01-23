//
//  BaseResponseObject.swift
//  DemoCode
//
//  Created by lieon on 16/9/18.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseResponseObject: Mappable {
    var statuses: [Status]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        statuses <- map["statuses"]
    }
    
    
}
