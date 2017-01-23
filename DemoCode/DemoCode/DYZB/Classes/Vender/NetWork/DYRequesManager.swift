//
//  DYRequesManager.swift
//  DemoCode
//
//  Created by lieon on 16/9/30.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import PromiseKit

enum DYMethod {
    case post
    case get
}

func dyHandleRequest<T: Mappable>(URLString: String, method:DYMethod? = .get, param:Mappable? = nil ) -> Promise<T> {
     let url = URL(string: URLString)!
    let requestMthod = method == .post ? HTTPMethod.post: HTTPMethod.get
    let parameter = param?.toJSON()
    return Promise { fulfill, reject in
      request(url, method: requestMthod, parameters: parameter).validate().responseJSON(completionHandler: { (response) in
        switch response.result {
        case .success(let value):
            guard let jsonString = value as? [String: AnyObject] else { return }
            print(jsonString)
            guard let object = Mapper<T>().map(JSON: jsonString) else { return }
            fulfill(object)
        case .failure(let error):
            reject(error)
        }

      })
    }

}
