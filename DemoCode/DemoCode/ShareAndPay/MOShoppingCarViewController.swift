//
//  MOShoppingCarViewController.swift
//  DemoCode
//
//  Created by lieon on 2016/11/28.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class MOShoppingCarViewController: UIViewController {

    fileprivate lazy var animator: TransitionAnimator = {[unowned self] in
        let animator = TransitionAnimator()
        let x: CGFloat = 0
        let height: CGFloat = self.view.bounds.height
        let y: CGFloat =  0
        let width = self.view.frame.width
        animator.presentFrame = CGRect(x: x, y: y, width: width, height: height)
        return animator
    }()
    fileprivate lazy var shoppingCar: UIButton = {
        let btn = UIButton(normalImage: "shoppingCart", selectedImage: "shoppingCart")
        return btn
    }()

    @IBAction func buyAction(_ sender: Any) {
    }
    
    @IBAction func addToShoppingCar(_ sender: Any) {
        guard let destVC = UIStoryboard(name: "Shop", bundle: nil).instantiateViewController(withIdentifier: "MOAddToCarViewController") as? MOAddToCarViewController else { return  }
        destVC.transitioningDelegate = animator
        destVC.modalPresentationStyle = .custom
        present(destVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupUI()
    }

}

extension MOShoppingCarViewController {
    fileprivate  func setupUI() {
        
    }
}
