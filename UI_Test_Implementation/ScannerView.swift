//
//  ScannerView.swift
//  TextMag
//
//  Created by Justin Lu on 2/17/24.
//

import Foundation
import SwiftUI
import VisionKit

struct DataScannerView: UIViewControllerRepresentable {
    @EnvironmentObject var sharedSettings: SharedSettings
    @EnvironmentObject var vm: AppViewModel
    @Binding var recognizedItems: [RecognizedItem]
    let recognizedDataType: DataScannerViewController.RecognizedDataType
    let recognizesMultipleItems: Bool
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let vc = DataScannerViewController(
            recognizedDataTypes: [recognizedDataType],
            qualityLevel: .accurate,
            recognizesMultipleItems: recognizesMultipleItems,
            isGuidanceEnabled: true,
            isHighlightingEnabled: true
        )
        return vc
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        uiViewController.delegate = context.coordinator
//        try? uiViewController.startScanning()
        
        if vm.isScanningFrozen && vm.cameraSnapshot == nil {
            // Capture a snapshot only if we're freezing and no snapshot has been captured yet
            uiViewController.stopScanning() // Stop scanning
            vm.cameraSnapshot = captureSnapshot(from: uiViewController.view)
        }

        if let snapshotImage = vm.cameraSnapshot {
            // Display the snapshot image to give the appearance of a frozen camera
            let imageView = UIImageView(image: snapshotImage)
            imageView.frame = uiViewController.view.bounds
            imageView.tag = 999  // Use a unique tag to identify the snapshot view
            // Ensure the snapshot view is added only once
            if uiViewController.view.viewWithTag(999) == nil {
                uiViewController.view.addSubview(imageView)
            }
        } else {
            // Remove the snapshot view to "unfreeze"
            uiViewController.view.viewWithTag(999)?.removeFromSuperview()
            try? uiViewController.startScanning()
        }

        
//        if vm.isScanningFrozen {
//            // Capture a snapshot and display it
//            captureSnapshot(from: uiViewController.view) { snapshot in
//                let imageView = UIImageView(image: snapshot)
//                imageView.frame = uiViewController.view.bounds
//                imageView.tag = 999 // Tag to identify the snapshot view
//                uiViewController.view.addSubview(imageView)
//                uiViewController.stopScanning() // Stop scanning
//            }
//        } 
//        else {
//            // Remove the snapshot view to unfreeze
//            uiViewController.view.subviews.first { $0.tag == 999 }?.removeFromSuperview()
//            try? uiViewController.startScanning() // Resume scanning
//        }

    }
    
//    func captureSnapshot(from view: UIView, completion: @escaping (UIImage?) -> Void) {
//        DispatchQueue.main.async {
//            UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
//            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
//            let snapshotImage = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            completion(snapshotImage)
//        }
//    }
    
    func captureSnapshot(from view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedItems: $recognizedItems, sharedSettings: sharedSettings)
    }
    
    static func dismantleUIViewController(_ uiViewController: DataScannerViewController, coordinator: Coordinator) {
        uiViewController.stopScanning()
        coordinator.removeTextOverlays()
    }
    
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var sharedSettings: SharedSettings
        @Binding var recognizedItems: [RecognizedItem]
        var textOverlayViews: [UIView] = []

        init(recognizedItems: Binding<[RecognizedItem]>, sharedSettings: SharedSettings) {
            self._recognizedItems = recognizedItems
            self.sharedSettings = sharedSettings
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
//            print("didTapOn \(item)")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            recognizedItems.append(contentsOf: addedItems)
            
            if (sharedSettings.experimentalMode) {
                DispatchQueue.main.async {
                    self.updateTextOverlays(in: dataScanner, with: allItems)
                }
            }
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            
            self.recognizedItems = recognizedItems.filter { item in
                !removedItems.contains(where: {$0.id == item.id })
            }
            
            if (sharedSettings.experimentalMode) {
                DispatchQueue.main.async {
                    self.updateTextOverlays(in: dataScanner, with: allItems)
                }
            }
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, becameUnavailableWithError error: DataScannerViewController.ScanningUnavailable) {
            print("Error localized description: \(error.localizedDescription)")
        }
        
        
        // AR FUNCTIONALITY BELOW
        private func updateTextOverlays(in dataScanner: DataScannerViewController, with recognizedItems: [RecognizedItem]) {
            
            let screenSize = UIScreen.main.bounds.size
            removeTextOverlays()

            for item in recognizedItems {
                
                if case let .text(text) = item {
                   // Get bounding box from recognized item data
                    var boundingBox = self.convertBoundsToCGRect(item.bounds, in: dataScanner.view).insetBy(dx: -110, dy: -50) // original dx: -120, dy: -50
                    
                    // Fix clipping (hopefully)
                    boundingBox.origin.x = max(boundingBox.origin.x, 0)
                    boundingBox.origin.y = max(boundingBox.origin.y, 0)

                    if boundingBox.maxX > screenSize.width {
                        boundingBox.size.width = screenSize.width - boundingBox.origin.x
                    }

                    if boundingBox.maxY > screenSize.height {
                        boundingBox.size.height = screenSize.height - boundingBox.origin.y
                    }
                    
                    // Make UITextView
                    let textView = UITextView(frame: boundingBox)
                    
                    
                    textView.backgroundColor = .clear // Change this to non-clear if debugging/tweaking boundingBox insets
                    textView.text = text.transcript
                    
                    textView.font = sharedSettings.fontChoice.withSize(calculateFontSize(for: textView, with: text.transcript)) // Dynamic font sizing
                    
                    textView.textColor = sharedSettings.ARColor
                    textView.isEditable = false
                    textView.isScrollEnabled = false
                    
                    textView.textAlignment = .center
                    textView.textContainer.lineBreakMode = .byTruncatingTail
                    
                    let rotationAngle = self.calculateRotationAngle(for: text.bounds)
                    textView.transform = CGAffineTransform(rotationAngle: rotationAngle)

                    dataScanner.view.addSubview(textView)
                    textOverlayViews.append(textView)
                }
            }
        }

        func removeTextOverlays() {
            for view in textOverlayViews {
                view.removeFromSuperview()
            }
            textOverlayViews.removeAll()
        }
                
        private func convertBoundsToCGRect(_ bounds: RecognizedItem.Bounds, in view: UIView) -> CGRect {
            let points = [bounds.topLeft, bounds.topRight, bounds.bottomRight, bounds.bottomLeft]
            let convertedPoints = points.map { view.convert($0, from: view.window) }
            let minX = convertedPoints.map { $0.x }.min() ?? 0
            let minY = convertedPoints.map { $0.y }.min() ?? 0
            let maxX = convertedPoints.map { $0.x }.max() ?? 0
            let maxY = convertedPoints.map { $0.y }.max() ?? 0
            return CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
        }
        
        private func calculateFontSize(for textView: UITextView, with text: String) -> CGFloat {
            let maxSize = textView.frame.size
            var fontSize: CGFloat = 24 // Start with a default font size
            var fitsWithinBounds = false

            while fontSize > 7 && !fitsWithinBounds { // Don't go below a minimum font size
                let font = UIFont.systemFont(ofSize: fontSize)
                let textAttributes: [NSAttributedString.Key: Any] = [.font: font]
                let attributedText = NSAttributedString(string: text, attributes: textAttributes)

                // Calculate the bounding rect for the attributed text, considering the maximum size
                let textRect = attributedText.boundingRect(with: CGSize(width: maxSize.width, height: .greatestFiniteMagnitude),
                                                           options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                           context: nil)

                // Check if the calculated rect fits within the bounding box's height
                if textRect.size.height <= maxSize.height && textRect.size.width <= maxSize.width {
                    fitsWithinBounds = true
                } else {
                    fontSize -= 2 // Reduce the font size and try again
                }
            }
            return fontSize
        }

        
        private func calculateRotationAngle(for bounds: RecognizedItem.Bounds) -> CGFloat {
            let p1 = bounds.topLeft
            let p2 = bounds.topRight

            // Calculate the angle in radians between the horizontal and the line through p1 and p2
            let deltaY = p2.y - p1.y
            let deltaX = p2.x - p1.x
            let angleInRadians = atan2(deltaY, deltaX)

            return angleInRadians
        }
    }
    
}
