//source https://www.hackingwithswift.com/books/ios-swiftui/wrapping-a-uiviewcontroller-in-a-swiftui-view
import SwiftUI
import UIKit

struct ScannerViewControllerRepresentable: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> ScannerViewController {
        let view = ScannerViewController()
        
        view.navigationController?.setNavigationBarHidden(true, animated: false)
        return view
    }
    
    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) {
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate {
        var parent: ScannerViewControllerRepresentable
        
        init(_ parent: ScannerViewControllerRepresentable) {
            self.parent = parent
        }
    }
}
