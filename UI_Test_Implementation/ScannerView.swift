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
    
    @Binding var recognizedItems: [RecognizedItem]
    let recognizedDataType: DataScannerViewController.RecognizedDataType
    let recognizesMultipleItems: Bool
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let vc = DataScannerViewController(
            recognizedDataTypes: [recognizedDataType],
            qualityLevel: .fast,
            recognizesMultipleItems: recognizesMultipleItems,
            isGuidanceEnabled: true,
            isHighlightingEnabled: true
        )
        return vc
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        uiViewController.delegate = context.coordinator
        try? uiViewController.startScanning()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedItems: $recognizedItems)
    }
    
    static func dismantleUIViewController(_ uiViewController: DataScannerViewController, coordinator: Coordinator) {
        uiViewController.stopScanning()
        coordinator.removeTextOverlays()
    }
    
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        
        @Binding var recognizedItems: [RecognizedItem]
        var textOverlayViews: [UIView] = []

        init(recognizedItems: Binding<[RecognizedItem]>) {
            self._recognizedItems = recognizedItems
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
//            print("didTapOn \(item)")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            recognizedItems.append(contentsOf: addedItems)
//            print("didAddItems \(addedItems)")
            
            DispatchQueue.main.async {
                self.updateTextOverlays(in: dataScanner, with: allItems)
            }
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            self.recognizedItems = recognizedItems.filter { item in
                !removedItems.contains(where: {$0.id == item.id })
            }
            
            DispatchQueue.main.async {
                self.updateTextOverlays(in: dataScanner, with: allItems)
            }
//            print("didRemovedItems \(removedItems)")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, becameUnavailableWithError error: DataScannerViewController.ScanningUnavailable) {
            print("Error localized description: \(error.localizedDescription)")
        }
        
        
        // AR FUNCTIONALITY BELOW
        private func updateTextOverlays(in dataScanner: DataScannerViewController, with recognizedItems: [RecognizedItem]) {
            removeTextOverlays()

            for item in recognizedItems {
                if case let .text(text) = item {
                    let boundingBox = self.convertBoundsToCGRect(text.bounds, in: dataScanner.view).insetBy(dx: -20, dy: -20)
                    let textView = UITextView(frame: boundingBox)
                    textView.backgroundColor = .clear
                    textView.text = text.transcript
                    textView.font = UIFont.systemFont(ofSize: calculateFontSize(for: textView, with: text.transcript)) // Dynamic font size
                    textView.textAlignment = .center
                    textView.isEditable = false
                    textView.isScrollEnabled = false
                    textView.textContainer.lineBreakMode = .byWordWrapping
                    
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
            // This is a basic implementation. You may need a more sophisticated approach to handle different text lengths and bounding box sizes.
            let maxSize = textView.frame.size
            var fontSize: CGFloat = 24 // Start with a default font size

            let textAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: fontSize)]
            let attributedText = NSAttributedString(string: text, attributes: textAttributes)
            let textRect = attributedText.boundingRect(with: CGSize(width: maxSize.width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

            // Reduce font size until the text fits within the bounding box
            while textRect.size.height > maxSize.height && fontSize > 10 { // Don't go below a minimum font size
                fontSize -= 1
                let newAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: fontSize)]
                let newAttributedText = NSAttributedString(string: text, attributes: newAttributes)
                let newTextRect = newAttributedText.boundingRect(with: CGSize(width: maxSize.width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

                if newTextRect.size.height <= maxSize.height {
                    break
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