//
//  DYShowRoomViewController.swift
//  DemoCode
//
//  Created by lieon on 2016/10/16.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class DYShowRoomViewController: UIViewController {
    var anchor: DYAnchor?
    fileprivate lazy var roomViewModel: DYRoomViewModel = DYRoomViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
         loadRoomData()
    }

}

extension DYShowRoomViewController {
    fileprivate  func loadRoomData()  {
        roomViewModel.requestRoomData(roomID: anchor?.room_id ?? "") {
            print(self.roomViewModel.room)
        }
    }
}
