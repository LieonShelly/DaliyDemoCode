//
//  CHWebSocket.swift
//  CHWebSocketSDK
//
//  Created by lieon on 2016/12/7.
//  Copyright © 2016年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import SocketRocket

private let socket = CHWebSocket()
public class CHWebSocket: NSObject {
    static public var shared: CHWebSocket {
        return socket
    }
    public var didOpenCompletionHandler:((_ webSocket: SRWebSocket) -> Void)?
    public var didCloseCompletionHandler:((_ webSocket: SRWebSocket, _ code: Int, _ reason: String, _ wasClean: Bool) -> Void)?
    public var didFailCompletionHandler:((_ webSocket: SRWebSocket, _ error: Error) -> Void)?
    public var didReceiveMessageCompletionHandler:((_ webSocket: SRWebSocket, _ message: Any) -> Void)?
    public var didReceivePongCompletionHandler:((_ webSocket: SRWebSocket, _ pongPayload: Data) -> Void)?
    public var didRegisterCallBack:((_ registerID: String) -> Void)?
    fileprivate lazy var websockect: SRWebSocket = SRWebSocket()
    fileprivate lazy var appInfo: AppInfo = AppInfo.standard
}

extension CHWebSocket {
    
    public func setup(appKey: String, appSecret: String) {
        appInfo.appKey = appKey
        appInfo.appSecret = appSecret
        connect(appKey: appKey, appSecret: appSecret)
        setupTimer()
    }
    
    public func close() {
        websockect.close()
    }
    
    public func send(_ data: Any!) {
        let socketqueue = DispatchQueue(label: "socketqueue")
        socketqueue.async {
            switch self.websockect.readyState {
            case .OPEN:
                self.websockect.send(data)
            case .CLOSING, .CLOSED:
                self.reconnect()
            case .CONNECTING:
                 print("websocket连接中...")
            }
        }
    }
    
    public func sendPing(_ data: Data) {
        let socketqueue = DispatchQueue(label: "socketqueue")
        socketqueue.async {
            switch self.websockect.readyState {
            case .OPEN:
                self.websockect.sendPing(data)
            case .CLOSING, .CLOSED:
                self.reconnect()
            case .CONNECTING:
                 print("websocket连接中...")
            }
        }
    }
    
    public func registerDevice(deviceToken: String, applePushToken: String? = nil, platform: String = "ios") {
        var param = [String: String]()
        if let pushToken = applePushToken {
            param = ["device_token": deviceToken,
                     "apple_push_token": pushToken,
                     "type": "register",
                     "platform": platform]
        } else {
            param = ["device_token": deviceToken,
                     "type": "register",
                     "platform": platform]
        }
        send(param.toJSONString())
    }
    
    public func removeDevice() {
        guard let registrationID = appInfo.registerID else {  fatalError("registerID is nil")  }
        let  param = ["registration_id": registrationID,
                      "type": "delete"]
        send(param.toJSONString())
    }
    
    public func loginDevice(registrationID: String) {
        let  param = ["registration_id": registrationID,
                      "type": "login"]
        send(param.toJSONString())
    }
    
    internal func setup(deviceToken: String) {
        appInfo.deviceToken = deviceToken
        registerDevice(deviceToken: deviceToken)
    }
    
    public func setup(applePushToken: String) {
        appInfo.applePushToken = applePushToken
        registerDevice(deviceToken: appInfo.deviceToken, applePushToken: applePushToken, platform: "ios")
    }
    
    public func reconnect() {
        if websockect.readyState != .OPEN {
            connect(appKey: appInfo.appKey, appSecret: appInfo.appSecret)
        }
    }
}



extension CHWebSocket: SRWebSocketDelegate {
    public func webSocketDidOpen(_ webSocket: SRWebSocket!) {
        if !appInfo.isRegisted {
            registerDevice(deviceToken: appInfo.deviceToken, applePushToken: appInfo.applePushToken)
        }
        if let block = didOpenCompletionHandler {
            block(websockect)
        }
       
    }
    
    public func webSocket(_ webSocket: SRWebSocket!, didCloseWithCode code: Int, reason: String!, wasClean: Bool) {
        if let block = didCloseCompletionHandler {
            block(webSocket, code, reason, wasClean)
        }
        
    }
    
    private static var connectCount: Int = 0
    public func webSocket(_ webSocket: SRWebSocket!, didFailWithError error: Error!) {
        if CHWebSocket.connectCount > 10 {
            CHWebSocket.connectCount = 0
            fatalError("连接失败,重新连接尝试了\( CHWebSocket.connectCount) 次")
        }
        reconnect()
        CHWebSocket.connectCount = CHWebSocket.connectCount + 1
        if let block = didFailCompletionHandler {
            block(webSocket, error)
        }
    }
    
    public func webSocket(_ webSocket: SRWebSocket!, didReceiveMessage message: Any!) {
        if let jsonStr = message as? String {
            guard let jsonData = jsonStr.data(using: .utf8) else { return }
            guard let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any] else { return  }
            guard let jsonDict = dict else { return  }
            var callBackMessage: Any?
            if let dataDict = jsonDict["data"] as? [String: Any] {
                if let typeStr = dataDict["type"] as? String, let messageType = CHMessageType(rawValue: typeStr), let dataJson = dataDict["data"] as? [String: Any], let registerID = dataJson["registration_id"] as? String {
                    switch messageType {
                    case .userRegister:
                        appInfo.registerID = registerID
                        loginDevice(registrationID: registerID)
                        didRegisterCallBack?(registerID)
                        return
                    case.userDelete:
                        appInfo.registerID = nil
                        return
                    case .userLogin:
                        appInfo.registerID = registerID
                        return
                    }
                }
                if let msg = dataDict["msg"], !(msg as! String).isEmpty {
                    callBackMessage = msg
                } else if let  data = dataDict["data"] {
                    callBackMessage = data
                } else { }
            }
            
            if let block = didReceiveMessageCompletionHandler, let msgg = callBackMessage {
                block(webSocket, msgg)
            }
            
        }
        
    }
    
    public func webSocket(_ webSocket: SRWebSocket!, didReceivePong pongPayload: Data!) {
        if let block = didReceivePongCompletionHandler {
            block(webSocket, pongPayload)
        }
    }
}


extension CHWebSocket {
    fileprivate func connect(appKey: String, appSecret: String) {
        var request = URLRequest(url: URL(string: "wss://push.chcts.cc/ws")!)
        let header = ["Content-Type": "application/json",
                      "Authorization": "Basic " + (appKey+":"+appSecret).ch_ToBase64()!]
        header.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        websockect = SRWebSocket(urlRequest: request)
        websockect.delegate = self
        websockect.open()
    }
    
    fileprivate  func setupTimer() {
        _ = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.repeatConnect), userInfo: nil, repeats: true)
    }
    
    @objc  private func repeatConnect() {
        reconnect()
    }
    
}

private let info: AppInfo = AppInfo()
fileprivate class AppInfo: NSObject {
    static var standard: AppInfo {
        return info
    }
    var registerID: String? {
        didSet {
            if let id = registerID, !id.isEmpty {
                isRegisted = true
            } else {
                isRegisted = false
            }
        }
    }
    var appKey: String = ""
    var appSecret: String = ""
    var deviceToken: String = ""
    var applePushToken: String?
    var isRegisted: Bool = false
}

fileprivate enum CHMessageType: String {
    case userRegister = "user_register"
    case userDelete = "user_delete"
    case userLogin = "user_login"
}
