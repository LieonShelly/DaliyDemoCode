//
//  MainTabBarController.swift
//  DemoCode
//
//  Created by lieon on 16/9/13.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SnapKit
import PromiseKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildController()
        setupComposeBtn()
    }
    
    
    /// 使用代码控制屏幕的方向，可以在需要横屏的时候单独处理
    /// 设置支持的方向之后，当前的控制器以及子控制器都会遵守这个方向
    /// 如果播放视屏，通常是通过modal的方式展现的
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    /// private 能够保证方法私有，仅在当前对象呗访问
    /// 允许这个函数在“运行时”，通过 OC 的消息机制被调用
    @objc  private  func composeBtnClick() {
        print("composeBtn")
    }
    
    private lazy var composeBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.contactAdd)
        
        return btn
    }()
    
    private func setupChildController() {
        let array = [
            ["className": "HomeViewController", "title":"首页", "imageName": "sd"],
            ["className": "DiscoverViewController", "title": "发现", "imageName": "sd"],
            ["className": "Add", "title": "", "imageName": ""],
            ["className": "MessageViewController", "title": "消息", "imageName": "sd"],
            ["className": "ProfileViewController", "title": "我", "imageName": "ds" ],
            ]
        var arrayM = [UIViewController]()
        _ = array.map{
            let vc = controller(dict: $0)
            arrayM.append(vc)
        }
        viewControllers = arrayM
    }
    
    private  func controller(dict: [String: String]) -> UIViewController {
        guard let className = dict["className"],
            let title = dict["title"],
            let imageName = dict["imageName"],
            let cls = NSClassFromString(Bundle.main.namespace() + "." + className) as? UIViewController.Type
            
            else { return UIViewController() }
        
        let vc = cls.init()
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        
        /// 实例化导航控制，会调用push方法，将rootViewController压入堆栈
        let nav = MainNavigationController(rootViewController: vc)
        return nav
        
        
    }
    private  func setupComposeBtn() {
        tabBar.addSubview(composeBtn)
        let count = CGFloat(childViewControllers.count)
        /// 减1的目的是为了消除容错点，即减小了缩进的宽度，增加了按钮的宽度，防止穿帮
        let w = tabBar.bounds.size.width / count - 1
        /// insetBy相当于OC中的CGRectInset:正数向内缩进，负数向外扩展
        composeBtn.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        composeBtn.addTarget(self, action: #selector(composeBtnClick), for: UIControlEvents.touchUpInside)
    }
}

extension MainTabBarController {
   
}
