//
//  CHService.swift
//  CHPushWebSocketSDK
//
//  Created by lieon on 2016/12/13.
//  Copyright © 2016年 ChangHongCloudTechService. All rights reserved.
//

import UIKit

 public class CHService: NSObject {
    public class func setup(appKey: String, appSecret: String) {
        CHPushService.registerRemoteNotification()
        CHWebSocket.shared.setup(appKey: appKey, appSecret: appSecret)
        CHWebSocket.shared.setup(deviceToken: UUID().uuidString)
    }
}
