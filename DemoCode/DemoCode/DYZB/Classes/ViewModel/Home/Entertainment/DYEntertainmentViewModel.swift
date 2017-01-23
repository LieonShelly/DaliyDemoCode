//
//  DYEntertainmentViewModel.swift
//  DemoCode
//
//  Created by lieon on 2016/10/10.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit

class DYEntertainmentViewModel: DYBaseViewModel {
     lazy var menuDatas: [DYGame] = [DYGame]()

}

extension DYEntertainmentViewModel {
    func loadAllEntertainmentData(finisCallBack:@escaping ()->()){
        let param = EntertainmentParameter()
        param.time = Date.getCurrentTime()
        let req: Promise<DYBaseObject<DYAnchorGroup>> = dyHandleRequest(URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", method: .get, param: param)
        _ = req.then { [unowned self] (value) -> Void in
        guard let groups = value.data else {
                return
        }
        self.anchorGroups = groups
            for group in  self.anchorGroups {
                let game = DYGame()
                game.tag_name = group.tagName
                game.icon_url = group.iconUrl
                self.menuDatas.append(game)
                
            }
            self.menuDatas.removeFirst()
            finisCallBack()
        }
    }
}
