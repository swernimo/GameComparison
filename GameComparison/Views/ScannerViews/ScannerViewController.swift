//taken from https://www.hackingwithswift.com/example-code/media/how-to-scan-a-barcode
import AVFoundation
import UIKit
import SwiftUI

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var searchResults: SearchResultObersable = SearchResultObersable()
    var searchResultsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                    
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)

        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.code128, .code39, .code39Mod43, .code93, .ean13, .ean8, .interleaved2of5, .itf14]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }

    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }

    }

    func found(code: String) {
        API.searchByUPC(code, completion: { result in
            if let result = result {
                if (result.count == 0) {
                   DispatchQueue.main.async {
                    self.displayCodeNotFoundAlert(upc: code)
                   }
                } else {
                    self.captureSession.startRunning()
                    if(self.searchResultsView == nil) {
                        self.searchResults.results = result
                        self.displaySearchResults()
                    }
                }
            }
        })
    }
    
    private func displayCodeNotFoundAlert(upc: String) -> Void {
        let ac = UIAlertController(title:"Game Not Found", message: "Please search by game title", preferredStyle: .alert)
        let searchAction = UIAlertAction(title: "Search", style: .default, handler: { _ in
            if let name = ac.textFields![0].text {
                if (name != "") {
                    API.searchByTitle(title: name, completion: { results in
                    self.captureSession.startRunning()
                        if let results = results {
                            self.searchResults.results = results
                            if (results.count > 0) {
                                self.displaySearchResults()
                            } else {
                                self.displayNoResultsAlert()
                            }
                        }
                    })
                } else {
                    self.captureSession.startRunning()
                }
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            self.captureSession.startRunning()
        })
        ac.addTextField { textField in
            textField.placeholder = "Search By Name"
        }
        ac.addAction(searchAction)
        ac.addAction(cancelAction)
        
        self.present(ac, animated: true)
    }
    
    private func displaySearchResults() -> Void{
        //TODO: if only 1 search result is found go straight to detail page
        let resultsView = SearchResultsView()
        .environmentObject(self.searchResults)
        let host = UIHostingController(rootView: resultsView)
        DispatchQueue.main.async {
            host.view.translatesAutoresizingMaskIntoConstraints = true
            host.view.frame = self.view.frame.offsetBy(dx: 0, dy: (self.view.frame.height * 0.5))
            self.searchResultsView = host.view
            self.view.addSubview(self.searchResultsView )
            self.addChild(host)
        }
    }
    
    func addSwipe() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.right, .left, .up, .down]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: Selector(("handleSwipe:")))
            gesture.direction = direction
            self.view.addGestureRecognizer(gesture)
        }
    }

    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if(sender.direction == .down && self.searchResultsView != nil) {
            DispatchQueue.main.async {
                self.searchResultsView.removeFromSuperview()
                self.searchResultsView = nil
            }
        }
    }
    
    private func displayNoResultsAlert() -> Void {
        let ac = UIAlertController(title:"No Results Found", message: "Please enter another title and try again", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { _ in
        })
        ac.addAction(cancelAction)
        self.present(ac, animated: true)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
