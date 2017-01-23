//
//  MOCornertTagTableViewCell.swift
//  DemoCode
//
//  Created by lieon on 2016/11/28.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class MOCornertTagTableViewCell: UITableViewCell {
    var model: CateModel? {
        didSet {
             guard let cate = model else { return  }
             btn.setTitle(cate.value ?? "", for: .normal)
            btn.isSelected = cate.isSelected
            if btn.isSelected {
                btn.backgroundColor = UIColor.red
            } else {
                btn.backgroundColor = UIColor.white
            }
        }
    }
  
    var tapAction: ((_ model: String) -> ())?
    @IBOutlet fileprivate weak var btn: UIButton!
    @IBAction func btnAction(_ sender: UIButton) {
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedBackgroundView = UIView()
        backgroundView = UIView()
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.isUserInteractionEnabled = false
        btn.setTitleColor(UIColor.brown, for: .normal)
        btn.setTitleColor(UIColor.white, for: .selected)
        btn.imageView?.backgroundColor = UIColor.clear
    }
    
}
