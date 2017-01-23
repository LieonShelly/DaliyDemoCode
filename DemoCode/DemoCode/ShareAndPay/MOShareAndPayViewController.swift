//
//  MOShareAndPayViewController.swift
//  DemoCode
//
//  Created by lieon on 2016/11/25.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import MonkeyKing

class MOShareAndPayViewController: UIViewController {

    @IBAction func playAction(_ sender: Any) {
        MonkeyKing.deliver(MonkeyKing.Order.alipay(urlString: "https://example.com/pay.php?payType=alipay")) { result in
            print("result: \(result)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension MOShareAndPayViewController {

}
