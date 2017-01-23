//
//  DYRecommendViewModel.swift
//  DemoCode
//
//  Created by lieon on 16/10/1.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import PromiseKit
class DYRecommendViewModel: DYBaseViewModel {
     lazy var cycleModels: [DYCycle] = [DYCycle]()
     var gameGroups: [DYAnchorGroup] {
       var  groups = anchorGroups
        groups.removeFirst()
        groups.removeFirst()
        let moreGroup = DYAnchorGroup()
        moreGroup.tagName = "更多"
        moreGroup.iconUrl = nil
        groups.append(moreGroup)
        return groups
    }
     fileprivate lazy var bigDataGroup: DYAnchorGroup = DYAnchorGroup()
     fileprivate lazy var prettyGroup: DYAnchorGroup = DYAnchorGroup()
}

extension DYRecommendViewModel {
    func requestData(completeHandle: @escaping () -> ()) {
        let group = DispatchGroup()
        ///  最热
        group.enter()
        let req2: Promise<latestAnchors> = dyHandleRequest(URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom")
        _ = req2.then { (value) -> Void in
            self.bigDataGroup.tagName = "最新"
            self.bigDataGroup.roomList = value.data
            group.leave()
            print("bigdata")
        }
        /// 颜值
          group.enter()
        let req1: Promise<prettyAnchors> = dyHandleRequest(URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom")
        _ = req1.then { (value) -> Void in
            self.prettyGroup.tagName = "颜值"
            self.prettyGroup.roomList = value.data
            group.leave()
            print("verticalRoom")
        }
        /// 游戏相关
        group.enter()
        let req: Promise<gameAnchors> = dyHandleRequest(URLString: "http://capi.douyucdn.cn/api/v1/getHotCate")
        _ = req.then { (value) -> Void in
            guard let data = value.data else { return }
            self.anchorGroups = data
            group.leave()
            print("game")
        }
        
        group.notify(queue: DispatchQueue.main) { 
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            completeHandle()
        }
        
    }
    
    func requestCycleData(completeHandle: @escaping () -> ()) {
         weak var weakSelf = self
        let req: Promise<cycleModel> = dyHandleRequest(URLString: "http://www.douyutv.com/api/v1/slide/6")
        _ = req.then {  (value) -> Void in
            guard let models = value.data else { return }
         weakSelf!.cycleModels = models
         completeHandle()
        }
    }
}
