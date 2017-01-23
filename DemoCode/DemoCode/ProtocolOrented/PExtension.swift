//
//  PExtension.swift
//  DemoCode
//
//  Created by lieon on 2016/12/28.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

extension UIColor {
    static let myOwnColor = UIColor(red: 220/255, green: 210/255, blue: 211/255, alpha: 1.0)
}

extension DispatchTime: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = DispatchTime.now() + .seconds(value)
    }
}

extension DispatchTime: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = DispatchTime.now() + .milliseconds(Int(value * 1000))
    }
}

extension UITableView {
    /// cell类型自动转换
    func dequeueReusebleCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ViewNameReuseable {
         guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else { fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)") }
        return cell
    }
}

