//
//  DYPlayViewController.swift
//  DemoCode
//
//  Created by lieon on 2016/10/23.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import AVFoundation


class DYPlayViewController: UIViewController {
    fileprivate var videoConnect: AVCaptureConnection?
    fileprivate var previewLayer: AVCaptureVideoPreviewLayer?
    fileprivate var session: AVCaptureSession?
    fileprivate var videoInput: AVCaptureDeviceInput?
    fileprivate var movieFileoutput: AVCaptureFileOutput?
    fileprivate var outputFileURL: URL = URL(string: "  ")!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startScan()
        
    }
    
    @IBAction func stopScanAction(_ sender: AnyObject) {
        movieFileoutput?.stopRecording()
        previewLayer?.removeFromSuperlayer()
        session?.stopRunning()
        session = nil
    }
    
    @IBAction func switchSence(_ sender: AnyObject) {
        
        let roatationAnim = CATransition()
        roatationAnim.type = "oglFlip"
        roatationAnim.subtype = "fromLeft"
        roatationAnim.duration = 0.5
        view.layer.add(roatationAnim, forKey: nil)
        if session == nil{
            startScan()
        } else {
            // 1.校验videoInput是否有值
            guard let videoInput = videoInput else { return  }
            // 2.获取当前镜头
            let position: AVCaptureDevicePosition = videoInput.device.position == .front ? .back : .front
            // 3.创建新的input
            guard let deviceSession = AVCaptureDeviceDiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: position) else { return  }
            let devices = deviceSession.devices
            let tempDevices = devices?.filter { return $0.position == position }
            let newDevice = tempDevices?.first
            guard  let newVideoInput = try? AVCaptureDeviceInput(device: newDevice) else { return  }
            // 移除旧的输入，加入新的
            session?.beginConfiguration()
            session?.removeInput(videoInput)
            session?.addInput(newVideoInput)
            session?.commitConfiguration()
            self.videoInput = newVideoInput
        }
    }
}

extension DYPlayViewController {
    
    fileprivate  func setupUI() {
        view.backgroundColor = UIColor.white
    }
    
   fileprivate func startScan() {
    // 1.创建捕捉的会话
    let son = AVCaptureSession()
    // 2.设置视屏输入输出
    setupVedioSource(session: son)
    // 3.设置音频输入输出
    setupAudioSource(session: son)
    // 4.添加文件输出
//    let movieFileoutput = AVCaptureFileOutput()
    session?.addOutput(movieFileoutput)
    // 获取视屏的connection
//    let connection = movieFileoutput.connection(withMediaType: AVMediaTypeVideo)
    // 设置视屏的稳定模式
//    connection?.preferredVideoStabilizationMode = .auto
    // 4.添加预览视图层
    setupPreviewLayer(session: son)
    // 5.开始扫描
    son.startRunning()
    // 6.开始录制
    // FIXME: 实现协议时提示错误
//    movieFileoutput.startRecording(toOutputFileURL: outputFileURL, recordingDelegate: self)
    session = son
//    self.movieFileoutput = movieFileoutput
    }
    
    fileprivate  func setupVedioSource(session: AVCaptureSession) {
        // 1. 创建输入
        guard let deviceSession = AVCaptureDeviceDiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: .unspecified) else {
            return
        }
        
         guard let devices = deviceSession.devices else { return  }

         let frontDevices = devices.filter{ return $0.position == .front }
         guard let frontDevice = frontDevices.first else { return  }
        // 通过前置摄像头创建输入设备
         guard let videoInput = try? AVCaptureDeviceInput(device: frontDevice) else { return  }
        // 2.创建输出源
        // 2.1 创建视屏输出源
        let videoOutput = AVCaptureVideoDataOutput()
        // 2.2.设置代理,以及代理方法的执行队列（在代理方法中拿到采集到的数据）
        let queue = DispatchQueue.global()
        videoOutput.setSampleBufferDelegate(self, queue: queue)
        // 3.将输入输出添加到回话中 
        if session.canAddInput(videoInput) {
            session.addInput(videoInput)
        }
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
        }
        
        videoConnect = videoOutput.connection(withMediaType: AVMediaTypeVideo)
        self.videoInput = videoInput
        
    }
    
    fileprivate  func setupAudioSource(session: AVCaptureSession) {
          // 1.创建输入
        guard let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio) else {
         return
        }
        guard let audioInput = try? AVCaptureDeviceInput(device: device)else {
            return
        }
        // 2.创建输出源
        let audioOutput = AVCaptureAudioDataOutput()
        let queue = DispatchQueue.global()
        audioOutput.setSampleBufferDelegate(self, queue: queue)
        // 3.将输入&输出添加到会话中
        if session.canAddInput(audioInput) {
            session.addInput(audioInput)
        }
        if session.canAddOutput(audioOutput) {
            session.canAddOutput(audioOutput)
        }
        
    }
    
    fileprivate  func setupPreviewLayer(session: AVCaptureSession) {
         guard let layer = AVCaptureVideoPreviewLayer(session: session) else { return  }
        layer.frame = view.bounds
        view.layer.insertSublayer(layer, at: 0)
        previewLayer = layer
    }
}

extension DYPlayViewController: AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        if connection == videoConnect {
            print("视屏数据")
        } else {
            print("音频数据 ")
        }
    }
}

// FIXME: 实现协议时提示错误
//extension DYPlayViewController: AVCaptureFileOutputRecordingDelegate {
//    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
//        
//    }
//    
//    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
//        
//    }
//    
//}
