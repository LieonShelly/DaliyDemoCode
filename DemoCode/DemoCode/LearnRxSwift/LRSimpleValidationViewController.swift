//
//  LRSimpleValidationViewController.swift
//  DemoCode
//
//  Created by lieon on 2016/10/12.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

let minimalUsernameLength = 5
let minimalPasswordLength = 5
var disposeBag = DisposeBag()

class LRSimpleValidationViewController: UIViewController {
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var usernameValidOutlet: UILabel!
    
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var passwordValidOutlet: UILabel!
    
    @IBOutlet weak var doSomethingOutlet: UIButton!
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
 
    @IBOutlet weak var repeatPasswordOutlet: UITextField!
    @IBOutlet weak var repeaPwdValidOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameValidOutlet.text = "Username has to be at least \(5) characters"
        passwordValidOutlet.text = "Password has to be at least \(5) characters"
        let usernameValid = usernameOutlet.rx.text
            .map { $0.characters.count >= minimalUsernameLength }
            .shareReplay(1) // without this map would be executed once for each binding, rx is stateless by default
        let passwordValid = passwordOutlet.rx.text
            .map { $0.characters.count >= minimalPasswordLength } 
            .shareReplay(1)
        usernameValid
            .bindTo(passwordOutlet.rx.enabled)
            .addDisposableTo(disposeBag)
        usernameValid
            .bindTo(usernameValidOutlet.rx.hidden)
            .addDisposableTo(disposeBag)
        passwordValid
        .bindTo(passwordValidOutlet.rx.hidden)
        .addDisposableTo(disposeBag)
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .shareReplay(1)
        everythingValid
            // 将信号与订阅者进行绑定
            .bindTo(doSomethingOutlet.rx.enabled)
            // 将返回的结果丢弃
            .addDisposableTo(disposeBag)
        doSomethingOutlet.rx.tap.subscribe(onNext: { [weak self] in
            self?.showAlert()
            }, onError: nil, onCompleted: nil, onDisposed: nil)
        .addDisposableTo(disposeBag)
        
    }
    
    func showAlert() {
//        let alertView = UIAlertView(
//            title: "RxExample",
//            message: "This is wonderful",
//            delegate: nil,
//            cancelButtonTitle: "OK"
//        )
//        alertView.show()
    }
}
