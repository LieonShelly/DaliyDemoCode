//
//  DYMainNavigationController.swift
//  DemoCode
//
//  Created by lieon on 2016/10/16.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class DYMainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
         guard let sysPan = interactivePopGestureRecognizer else { return  }
        sysPan.isEnabled = false
         guard let panView = sysPan.view else { return  }
         guard let targets = sysPan.value(forKey: "_targets") as? [NSObject]?  else { return  }
        guard let target = targets?.first else { return  }
        guard let transiton = target.value(forKey: "target") else { return  }
        let action = Selector(("handleNavigationTransition:"))
        let newPan = UIPanGestureRecognizer()
        newPan.addTarget(transiton, action: action)
        panView.addGestureRecognizer(newPan)
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            navigationBar.isHidden = true
        } else {
             navigationBar.isHidden = false
        }
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }

}
