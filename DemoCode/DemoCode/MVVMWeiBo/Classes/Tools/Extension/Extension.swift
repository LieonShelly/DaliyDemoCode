//
//  Extension.swift
//  DemoCode
//
//  Created by lieon on 16/9/13.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import Kingfisher

extension Bundle {
    func namespace() -> String {
        let dict = Bundle.main.infoDictionary
         guard let dic = dict else { return "" }
        guard let namespace = dic["CFBundleExecutable"] as? String else { return ""}
        return namespace
    }
}

extension UIColor {
    class func randomColor() -> UIColor {
        let r = arc4random_uniform(256)
        let g = arc4random_uniform(256)
        let b = arc4random_uniform(256)
        return  UIColor(red: CGFloat(r)/256.0, green: CGFloat(g)/256.0, blue: CGFloat(b)/256.0, alpha: 1.0)
    }
    
    class func colorFromHex(_ rgbValue: UInt32, alpha: Double = 1.0) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/255.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/255.0
        let blue = CGFloat(rgbValue & 0xFF)/255.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}

extension UIButton {
    convenience init(normalImage: String, selectedImage: String) {
        self.init()
        let normalImage = UIImage(named: normalImage)
        let selectedImage = UIImage(named: selectedImage)
        self.setImage(normalImage, for: .normal)
        self.setImage(selectedImage, for: .selected)
        self.sizeToFit()
    }
}

extension UIImage {
    /// PNG图片支持透明的。JPEG图片不支持透明
    /// 将给定的图像进行拉伸，并返回新的图像,返回的是一个全新的图像，所以GPU没有对原始的图像进行按指定的尺寸进行拉伸，性能大大的提高
    /// - returns: UIImage
    func stretch(image: UIImage, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        image.draw(in: CGRect(origin: CGPoint(), size: size))
        let  result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    
    /// 绘制圆角图片
    ///
    /// - parameter size:            图片尺寸
    /// - parameter backColor:       圆角路径以外的颜色
    /// - parameter strokeLineColor: 圆角路径的颜色
    ///
    /// - returns: 新的图片
    func corner(imageSize: CGSize,cornerRadius: CGFloat = 5, backColor: UIColor = UIColor.white, strokeLineColor: UIColor = UIColor.white) -> UIImage? {
        let rect = CGRect(origin: CGPoint(), size: imageSize)
        UIGraphicsBeginImageContextWithOptions(imageSize, true, 0)
        // 0.背景填充
        backColor.set()
        UIRectFill(rect)
        // 1.实例化一个图片路径
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        // 2.对图片路径进行裁切（rect的内径圆）
        path.addClip()
        // 3.在指定的区域绘图
        self.draw(in: rect)
        // 4.绘制内切的圆形(即是边框)
        strokeLineColor.setStroke()
        path.lineWidth = 0
        path.stroke()
        // 5.取得绘图的结果
        let  result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    func cycle(imageSize: CGSize, backColor: UIColor = UIColor.white, strokeLineColor: UIColor = UIColor.white) -> UIImage? {
        let rect = CGRect(origin: CGPoint(), size: imageSize)
        UIGraphicsBeginImageContextWithOptions(imageSize, true, 0)
        // 0.背景填充
        backColor.set()
        UIRectFill(rect)
        // 1.实例化一个图片路径
        let path = UIBezierPath(ovalIn: rect)
        // 2.对图片路径进行裁切（rect的内径圆）
        path.addClip()
        // 3.在指定的区域绘图
        self.draw(in: rect)
        // 4.绘制内切的圆形(即是边框)
        strokeLineColor.setStroke()
        path.lineWidth = 0
        path.stroke()
        // 5.取得绘图的结果
        let  result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
}

extension UIScreen {
    class func width() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    class func height() -> CGFloat {
        return UIScreen.main.bounds.height
    }
}

extension Date {
    static func getCurrentTime() -> String {
        let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}

extension UITableView {
    /*
     弹出一个静态的cell，无须注册重用，例如:
     let cell: GrayLineTableViewCell = tableView.mm_dequeueStaticCell(indexPath)
     即可返回一个类型为GrayLineTableViewCell的对象
     
     - parameter indexPath: cell对应的indexPath
     - returns: 该indexPath对应的cell
     */
    func lieon_dequeueStaticCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
        let reuseIdentifier = "staticCellReuseIdentifier - \(indexPath.description)"
        if let cell = self.dequeueReusableCell(withIdentifier: reuseIdentifier) as? T {
            return cell
        }else {
            let cell = T(style: .default, reuseIdentifier: reuseIdentifier)
            return cell
        }
    }
}

extension UIView {
    func commonSuperview(of view: UIView) -> UIView? {
        return superview.flatMap {
            view.isDescendant(of: $0) ?
                $0 : $0.commonSuperview(of: view)
        }
    }
 
}

extension CGFloat {
    public static let pi = 3.14
}

