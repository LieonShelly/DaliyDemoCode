//
//  Model.swift
//  DemoCode
//
//  Created by lieon on 2016/12/28.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

//数据源
var festivalsData = [["date":"2月14日","name":"情人节"],["date":"1月1日","name":"元旦节"]]
var eventsData = [["date":"2月14日","title":"买礼物","warning":false],["date":"1月20日","title":"同学聚会","warning":true]]

struct PModel: Big {
    func a() {
        
    }
    func b() {
        
    }
    
    func c() {
        
    }
    
    func d() {
        
    }
}

struct UserConfig: BoolDefaultSettable {
    /// 外部指定关联的具体类型
    enum BoolKey: String {
        case isEve
    }
}

/// 定义类型擦除来保存上下文
protocol Drive {
    associatedtype Power
    func drive(by power: Power)
}

struct Oil { }
struct Electricity { }

struct Cayenne: Drive {
    func drive(by power: Oil) {
        
    }
}

struct Panamera: Drive {
    func drive(by power: Oil) {
    }
}

struct Tesla: Drive {
    func drive(by power: Electricity) {
        
    }
}

struct AnyOilDrive<T>: Drive {
    private let _drive: (T) -> Void
    
    init<Raw: Drive>(_ rawDerive: Raw) where Raw.Power == T {
        _drive = rawDerive.drive
    }
    
    func drive(by power: T) {
        _drive(power)
    }
}
/// 在保证静态数据的同时，保证了准守者的原始实现
let oilDrive: [AnyOilDrive<Oil>] = [AnyOilDrive(Panamera()), AnyOilDrive(Cayenne())]

//节日模型
struct Festival:HasDate {
    var date = ""
    var festivalName = ""
    //新建构造器
    init(dic:[String:Any]){
        date = dic["date"] as? String ?? "日期错误"
        festivalName = dic["name"] as? String ?? "节日名错误"
    }
    
    //因为模型要放在数组中，也可以使用允许失败的构造器或者抛出错误的构造器，在填充数组时使用 flatMap：
    init?(dataDic:[String:Any]) {
        guard let date = dataDic["date"] as? String,
            let festivalName = dataDic["name"] as? String
            else {
                return nil
        }
        self.date = date
        self.festivalName = festivalName
    }
}

//待办事宜模型
struct Event:HasDate {
    var date = ""
    var eventTitle = ""
    //新增属性
    var warning = false
    //新建构造器
    init(dic:[String:Any]){
        date = dic["date"] as? String ?? "日期错误"
        eventTitle = dic["title"]  as? String ?? "事件名错误"
        //新增初始化
        warning = dic["warning"] as? Bool ?? false
    }
}

extension Festival: DataModel {}
extension Event: DataModel {}

protocol HasDate {
    var date:String {get set}
}

enum DateModelBox {
    case festival(Festival)
    case event(Event)
    /// 内嵌枚举
    private enum ModelType: String {
        case festival, event
    }
    
    init?(dic: [String: Any], typeTag: String) {
         guard let type = ModelType(rawValue: typeTag) else { return nil }
        switch type {
        case .festival:
            self = .festival(Festival(dic: dic))
        case .event:
            self = .event(Event(dic: dic))
        }
    }
}

struct PDemoDataModel {
    var mixedArray:[DateModelBox] = []
    init() {
        mixedArray += festivalsData.flatMap { DateModelBox(dic: $0, typeTag: "festival")}
        mixedArray += eventsData.flatMap {
            DateModelBox(dic: $0, typeTag: "event")
        }
        
        mixedArray.sort{
            switch ($0,$1) {
            case (.event(let first),.event(let second)):
                return first.date < second.date
            case (.festival(let first),.event(let second)):
                return first.date < second.date
            case (.event(let first),.festival(let second)):
                return first.date < second.date
            case (.festival(let first),.festival(let second)):
                return first.date < second.date
                
            }
        }
    }
}

