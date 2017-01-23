//
//  DYRoomViewModel.swift
//  DemoCode
//
//  Created by lieon on 2016/11/13.
//  Copyright © 2016年 lieon. All rights reserved.
//

import Foundation
import PromiseKit

class DYRoomViewModel {
    var room: DYAnchorRoom = DYAnchorRoom()
    
    func requestRoomData(roomID: String, finishCallBack: @escaping () ->())  {
        let param = RoomDataRequestParameter()
        param.roomID = roomID
        let req: Promise<DYSingleBaseObject<DYAnchorRoom>> = dyHandleRequest(URLString: "http://capi.douyucdn.cn/api/v1/room/", method: .get, param: param)
        req.then { (value) -> Void in
            if let room = value.data {
                self.room = room
            }
        }.catch { (error) in
            print(error)
        }
    }
}
