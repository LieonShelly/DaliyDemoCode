//
//  DYFunnyViewModel.swift
//  DemoCode
//
//  Created by lieon on 2016/10/16.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import PromiseKit

class DYFunnyViewModel: DYBaseViewModel {
    
    func loadFunnyData(finishCallBack: @escaping () -> ()) {
        let param = FunnyDataParameter()
        param.limit = 30
        param.offset = 0
        let req: Promise<DYBaseObject<DYAnchor>> = dyHandleRequest(URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", method: .get, param: param)
        req.then { (value) -> Void in
           let  group = DYAnchorGroup()
            group.roomList = value.data
            self.anchorGroups.append(group)
            finishCallBack()
            }.catch{ _ in }
    }
}
