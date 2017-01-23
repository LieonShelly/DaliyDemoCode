//
//  MOAddNumTableViewCell.swift
//  DemoCode
//
//  Created by lieon on 2016/11/29.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class MOAddNumTableViewCell: UITableViewCell {
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    var numChangeAction: ((_ num: Int) -> ())?
    
    fileprivate  var num: Int = 0 {
        didSet {
            valueLabel.text = "\(num)"
            if let block = numChangeAction {
                block(num)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func addAction(_ sender: Any) {
        num = num + 1
    }
    
    @IBAction func decreaseAcrion(_ sender: Any) {
        if num == 0 {
            num = 0
            return
        }
        num = num - 1
    }
}
