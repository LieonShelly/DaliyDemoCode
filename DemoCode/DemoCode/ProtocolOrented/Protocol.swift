//
//  Protocol.swift
//  DemoCode
//
//  Created by lieon on 2016/12/28.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

protocol Small {
    func a()
    func b()
}

protocol Little {
    func c()
    func d()
}

typealias Big = Small & Little

protocol KeyNamespaceble {
    static func namespaced<T: RawRepresentable>(_ key: T) -> String
}

extension KeyNamespaceble {
    static func namespaced<T: RawRepresentable>(_ key: T) -> String {
         return String(describing: self) + ".\(key.rawValue)"
    }
}

protocol BoolDefaultSettable: KeyNamespaceble {
    /// 定义一个关联类型
    associatedtype BoolKey: RawRepresentable
}

extension BoolDefaultSettable where BoolKey.RawValue == String   {
    static func set(_ value: Bool, forKey key: BoolKey) {
        UserDefaults.standard.set(value, forKey: namespaced(key))
    }
    
    static func bool(forKey key: BoolKey) -> Bool {
      return UserDefaults.standard.bool(forKey: namespaced(key))
    }
}

/// segue的改造
protocol SegueHandlerType {
    associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {
    /// 利用自建的类型执行perform
    func performSegue(with identifier: SegueIdentifier, sender: Any) {
        performSegue(withIdentifier: identifier.rawValue, sender: sender)
    }
    
    /// 对应prepare方法，只需要返回对应的identifier
    func sgueIdentifier(for segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifier = segue.identifier, let segueidtntifier = SegueIdentifier(rawValue: identifier) else {  fatalError("Invalid segue identifier \(segue.identifier).")}
        return segueidtntifier
    }
}



/// cell的自动转换
protocol ViewNameReuseable: class {
    
}

extension ViewNameReuseable where Self: UIView {
    /// 重用id为cell的类名
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

/// 视图使用的协议
protocol View {
    func get<M: DataModel>(data model: M)
}

extension View {
    func get<M: DataModel>(data model: M) {
        
    }
}

extension View where Self: DemoShowedCell {
    func get<M: DataModel>(data model: M) {
        /// 先从公有的底层协议开始筛选，对于不是HasDate协议遵守者的模型提前返回
         guard let hasDate = model as? HasDate else { return  }
        /// 共有部分
        dateLabel.text = hasDate.date
        /// 再筛选顶层类型
        if let festival = model as? Festival {
            //筛选出Festival模型进行绑定
            tagImageView.image = UIImage(named: "fes")
            titleLabel.text = festival.festivalName
        } else if let event = model as? Event {
            //筛选出Event模型进行绑定
            //组合
            var styleTuple:(imgName:String,color:UIColor,btnHidden:Bool) {
                if event.warning {
                    return ("eve_hl",UIColor.red,false)
                } else {
                    return ("eve",UIColor.black,true)
                }
            }
            //应用组合后的样式
            tagImageView.image = UIImage(named: styleTuple.imgName)
            titleLabel.textColor = styleTuple.color
            dateLabel.textColor = styleTuple.color
            warningBtn.isHidden = styleTuple.btnHidden
            titleLabel.text = event.eventTitle
        }
    }
}

/// 数据使用的协议
protocol DataModel {
    
}

extension DataModel {
    func give<V: View>(data view: V) {
         view.get(data: self)
    }
}

///  复用绑定逻辑的协议
protocol DemoShowedCell {
    weak var tagImageView: UIImageView!{get set}
    
    weak var titleLabel: UILabel!{get set}
    
    weak var dateLabel: UILabel!{get set}
    
    weak var warningBtn: UIButton!{get set}
    //新增一个泛型的闭包类型
    var buttonPressedClouse: (Self) -> Void{get set}
}








