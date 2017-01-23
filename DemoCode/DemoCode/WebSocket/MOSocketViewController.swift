//
//  MOSocketViewController.swift
//  DemoCode
//
//  Created by lieon on 2016/11/29.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import SocketRocket

private let urlstr = "wss://push.chcts.cc/ws"
class MOSocketViewController: UIViewController {
    fileprivate var websockect: SRWebSocket = SRWebSocket()
    
    @IBAction func reconnectAction(_ sender: Any) {
        connect()
    }
    
    @IBAction func sendAction(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        websockect.close()
    }
}

extension MOSocketViewController {
    fileprivate  func setup() {
        connect()
    }
    
    fileprivate func connect() {
        self.title = "connectting"
        guard  let url = URL(string: "wss://push.chcts.cc/ws") else { return }
        let request = URLRequest(url: url)
//        websockect.delegate = nil
//        websockect.close()
        websockect = SRWebSocket(urlRequest: request)
        websockect.delegate = self
        websockect.open()
    }
}

extension MOSocketViewController: SRWebSocketDelegate {
    /*其中webSocketDidOpen是在链接服务器成功后回调的方法，在这里发送一次消息，把id 名字发送到服务器，告知服务器， == 注册*/
    func webSocketDidOpen(_ webSocket: SRWebSocket!) {
        print("websocket connected")
        title = "connected"
    }
    
    // 收到消息
    func webSocket(_ webSocket: SRWebSocket!, didReceiveMessage message: Any!) {
        print("recieveed:\(message)")
    }
    
    // 连接关闭
    func webSocket(_ webSocket: SRWebSocket!, didCloseWithCode code: Int, reason: String!, wasClean: Bool) {
        print("websoket closed")
        self.title = "closed"
    }
    
    // 匹配成功
    func webSocket(_ webSocket: SRWebSocket!, didReceivePong pongPayload: Data!) {
        print("WebSocket received pong")
    }
}

