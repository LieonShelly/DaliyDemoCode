//
//  LRNumbersViewController.swift
//  DemoCode
//
//  Created by lieon on 2016/10/11.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LRNumbersViewController: UIViewController {
    @IBOutlet weak var number1: UITextField!
    @IBOutlet weak var number2: UITextField!
    @IBOutlet weak var number3: UITextField!
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建一个序列，将number1，number2，number3的内容序列化
       _ = Observable.combineLatest(number1.rx.text, number2.rx.text, number3.rx.text) { (textValue1, textValue2, textValue3) -> Int in
            return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
        }.map { $0.description}
        .bindTo(result.rx.text)
    }

}
