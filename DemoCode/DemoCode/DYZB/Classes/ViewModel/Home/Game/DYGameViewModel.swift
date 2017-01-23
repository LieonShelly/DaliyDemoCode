//
//  DYGameViewModel.swift
//  DemoCode
//
//  Created by lieon on 2016/10/9.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import PromiseKit
import Alamofire

class  DYGameViewModel {
     lazy var games: [DYGame] = [DYGame]()
    lazy var commonGames: [DYGame] = [DYGame]()
}

extension DYGameViewModel {
    func loadAllGameData(fininshCallBack: @escaping () -> ())  {
        let param = HomeGameParameter()
        param.shortName = "game"
        
        let req: Promise<gameModel> = dyHandleRequest(URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", method: .get, param: param)
        _ = req.then { (value) -> Void in
            guard let games = value.data else { return }
            self.games = games
            for i in 0 ... 5 {
                 self.commonGames.append(games[i])
            }
            fininshCallBack()
        }
        
    }
}
