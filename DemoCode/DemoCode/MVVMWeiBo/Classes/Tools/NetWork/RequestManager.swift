//
//  RequestManager.swift
//  DemoCode
//
//  Created by lieon on 16/9/18.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import ObjectMapper
import PromiseKit

func requestLocalStatus() -> Promise<[StatusViewModel]> {
    return Promise { fulfill, reject in
        var statusViewModelArray = [StatusViewModel]()
        for i in 0 ... 8 {
            guard  let json = Bundle.main.path(forResource: "weibo_\(i).json", ofType: nil)  else {
                continue
            }
            do {
                let jsonStr =  try String(contentsOfFile: json)
                let responseObject =  Mapper<BaseResponseObject>().map(JSONString: jsonStr)
                let statusesArray = responseObject?.statuses ?? [Status]()
                let viewModelArray = statusesArray.map { return StatusViewModel(model: $0) }
                statusViewModelArray.append(contentsOf: viewModelArray)
            } catch {
                reject(error)
            }
        }
        fulfill(statusViewModelArray)
    }
}

func request(compeltion: (_ statusViewModelArray: [StatusViewModel]?, _ failure: NSError?) -> ()) {
    var statusViewModelArray = [StatusViewModel]()
    for i in 0 ... 8 {
        guard  let json = Bundle.main.path(forResource: "weibo_\(i).json", ofType: nil)  else {
            continue
        }
        do {
            let jsonStr =  try String(contentsOfFile: json)
            let responseObject =  Mapper<BaseResponseObject>().map(JSONString: jsonStr)
            let statusesArray = responseObject?.statuses ?? [Status]()
            let viewModelArray = statusesArray.map { return StatusViewModel(model: $0) }
            statusViewModelArray.append(contentsOf: viewModelArray)
        } catch {
            compeltion( nil , error as NSError)
        }
    }
     compeltion(statusViewModelArray, nil)
}
