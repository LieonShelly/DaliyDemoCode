//
//  DYMainTabBarController.swift
//  DemoCode
//
//  Created by lieon on 16/9/29.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class DYMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVCFromStroyboard(name: "DYHome")
        addChildVCFromStroyboard(name: "DYLive")
        addChildVCFromStroyboard(name: "DYFollow")
        addChildVCFromStroyboard(name: "DYProfile")
    }
  
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    private  func addChildVCFromStroyboard(name: String) {
     guard let chilcVC = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController() else { return  }
        addChildViewController(chilcVC)
    }
}
