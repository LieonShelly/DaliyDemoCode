//
//  PTableViewCell.swift
//  DemoCode
//
//  Created by lieon on 2016/12/28.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

final class PTableViewCell: UITableViewCell,DemoShowedCell {
    @IBOutlet weak  var tagImageView: UIImageView!
    @IBOutlet weak  var warningBtn: UIButton!
    @IBOutlet weak  var titleLabel: UILabel!
    @IBOutlet weak  var dateLabel: UILabel!
    var buttonPressedClouse: (PTableViewCell) -> Void = {cell in   }
    @IBAction func cancelWarning(_ sender: UIButton) {
        buttonPressedClouse(self)
     }
}
extension PTableViewCell: ViewNameReuseable {
    
}

extension PTableViewCell: View {
    
}

