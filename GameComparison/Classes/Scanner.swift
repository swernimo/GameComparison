//
//  Scanner.swift
//  GameComparison
//
//  Created by Personal on 7/15/20.
//  Copyright © 2020 TheBlindSquirrel. All rights reserved.
//

import Foundation
import AVFoundation
import SwiftUI

class Scanner: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    @EnvironmentObject var helper: ScannerHelper
    
    var captureSession: AVCaptureSession!
    
    override init() {
        super.init()
        self.captureSession = AVCaptureSession()
        
       guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
       let videoInput: AVCaptureDeviceInput

       do {
           videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
       } catch {
           return
       }

        if (self.captureSession.canAddInput(videoInput)) {
            self.captureSession.addInput(videoInput)
       } else {
        self.failed()
           return
       }

       let metadataOutput = AVCaptureMetadataOutput()

        if (self.captureSession.canAddOutput(metadataOutput)) {
            self.captureSession.addOutput(metadataOutput)

           metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
           metadataOutput.metadataObjectTypes = [.qr]
       } else {
        self.failed()
           return
       }
    }
    
    func failed() {
//        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
        //present(ac, animated: true)
        self.helper.failed = true
        self.helper.code = ""
        self.captureSession = nil
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        self.captureSession.stopRunning()

           if let metadataObject = metadataObjects.first {
               guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
               guard let stringValue = readableObject.stringValue else { return }
               AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
               found(code: stringValue)
           }

          // dismiss(animated: true)
       }

   func found(code: String) {
        self.helper.failed = false
        self.helper.code = code
   }
    
    func startSession() {
        if (self.captureSession?.isRunning == false) {
            self.captureSession.startRunning()
       }
    }
    
    func stopSession() {
        if (self.captureSession?.isRunning == true) {
            self.captureSession.stopRunning()
         }
    }
}
