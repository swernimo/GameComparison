//taken from https://www.hackingwithswift.com/example-code/media/how-to-scan-a-barcode
import AVFoundation
import UIKit
import SwiftUI

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var searchResults: SearchResultObersable = SearchResultObersable()
    var searchResultsView: UIView!
    var foundCodeCallback: ((_ code: String?) -> ())? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        AnalysticsService.shared.logEvent("Barcode Found", pageName: "Scanner View")
        if (foundCodeCallback != nil) {
            self.foundCodeCallback!(code)
        } else {
            API.searchByUPC(code, completion: { result in
                if (result == nil || result!.count == 0) {
                    DispatchQueue.main.async {
                        self.displayCodeNotFoundAlert(upc: code)
                    }
                }else {
                    self.captureSession.startRunning()
                    if(self.searchResultsView == nil) {
                        self.searchResults.results = result!
                        self.displaySearchResults()
                    }
                }
            })
        }
    }
    
    private func displayCodeNotFoundAlert(upc: String) -> Void {
        let ac = UIAlertController(title:"Game Not Found", message: "Please search by game title", preferredStyle: .alert)
        let searchAction = UIAlertAction(title: "Search", style: .default, handler: { _ in
            AnalysticsService.shared.logButtonClick("Search", pageName: "Game Not Found Alert")
            if let name = ac.textFields![0].text {
                if (name != "") {
                    API.searchByTitle(title: name, completion: { results in
                    self.captureSession.startRunning()
                        if let results = results {
                            DispatchQueue.main.async {
                                self.searchResults.results = results
                                if (results.count > 0) {
                                    self.displaySearchResults()
                                } else {
                                    self.displayNoResultsAlert()
                                }
                            }
                        }
                    })
                } else {
                    self.captureSession.startRunning()
                }
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            AnalysticsService.shared.logButtonClick("Cancel", pageName: "Game Not Found Alert")
            self.captureSession.startRunning()
        })
        ac.addTextField { textField in
            textField.placeholder = "Search By Name"
        }
        ac.addAction(searchAction)
        ac.addAction(cancelAction)
        AnalysticsService.shared.logPageView("Game Not Found Alert")
        self.present(ac, animated: true)
    }
    
    private func displaySearchResults() -> Void{
        let resultsView = SearchResultsView(showCloseButton: true, closeBtnCallback: {
            self.searchResultsView.removeFromSuperview()
        })
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
