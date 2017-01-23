//
//  CarViewModel.swift
//  DemoCode
//
//  Created by lieon on 2016/11/28.
//  Copyright © 2016年 lieon. All rights reserved.
//

import Foundation

class CarViewModel {
    var lastSelectedIndexPath: IndexPath?
   lazy var goods: MOGoods =  MOGoods()
   lazy var cate: [CateModel] = [CateModel]()

    func loadGoods(finishCallBack: () -> ()) {
        let goods = MOGoods()
        goods.imageURL = URL(string: "")
        goods.price = "13.00"
        let cateModel = CateModel()
        cateModel.value = "5.5寸 玫瑰金 -【保护摄像头】-现货"
        goods.cateStr = [cateModel,cateModel,cateModel]
        goods.stockNum = "999"
        self.goods = goods
        self.cate = goods.cateStr
        finishCallBack()
    }
    
}
