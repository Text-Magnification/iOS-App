//
//  ViewController.swift
//  TextMag
//
//  Created by Daniel Iskandar on 2/12/24.
//

import AVFoundation
import UIKit
import Vision


class ViewController: UIViewController {
    
    // Custom text label for view
    let label: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .lightGray
        return label
    }()
    
    // Custom image frame for view
    let imageView: UIImageView = {
       let imageView = UIImageView()
//        imageView.image = UIImage(named: "example3") // Insert image here
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // Capture Session
    var session: AVCaptureSession?
    // Photo Output
    let output = AVCapturePhotoOutput()
    // Video Preview
    let previewLayer = AVCaptureVideoPreviewLayer() // Layer to add actual camera
                                                    //feed session
    // Shutter Button
    private let shutterButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        //Change width and height to 100?
        button.layer.cornerRadius = 75 //MODIFY FOR SHUTTER 50?
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.brown.cgColor
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        previewLayer.backgroundColor = UIColor.systemBlue.cgColor
        view.layer.addSublayer(previewLayer)
        view.addSubview(shutterButton)
        checkCameraPermissions()
        
        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
        
        shutterButton.center = CGPoint(x: view.frame.size.width/2,
                                       y: view.frame.size.height - 200)
        //Maybe change to 100?
        
        imageView.frame = CGRect(x: 20,
                                 y: view.safeAreaInsets.top,
                                 width: view.frame.size.width-40,
                                 height: view.frame.size.width-40)
        
        label.frame = CGRect(x: 20,
                             y: view.frame.size.width + view.safeAreaInsets.top,
                             width: view.frame.size.width-40,
                             height: 200)
    }
    
    private func recognizeText(image: UIImage?) {
        
        // Guard valid input image and get cgImage, else return
        guard let cgImage = image?.cgImage else {fatalError("Could not get cgImage!")}
        
        // Create handler:
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        // Create request:
        // 1. Get observed image info out of the request
        // 2. cast as VNRecognizedTextObservation and catch any errors
        let request = VNRecognizeTextRequest{[weak self] request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation],
                    error == nil else {
                return
            }
            
            // Get text string from VNRecognizedTextObservation object
            
            // Vision will try to segment text, so text may contain multiple text observations
            let text = observations.compactMap({$0.topCandidates(1).first?.string}).joined(separator: ", ")
            
            DispatchQueue.main.async {
                self?.label.text = text
            }
        }
        
        // Process request
        do {
            try handler.perform([request])
        }
        catch {
            label.text = "\(error)"
        }
    }
    
    private func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            // Request
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else {
                    return
                }
                DispatchQueue.main.async {
                    self?.setUpCamera()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setUpCamera()
        @unknown default:
            break
        }
    }
    
    private func setUpCamera() {
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                // Some devices can't use back camera, not relevant for our purpose
                // but potentially good for testing
                    session.addInput(input)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session //Add this session to the preview layer
                
                session.startRunning()
                self.session = session //Retain session
            }
            catch {
                print(error)
            }
        }
    }
    
    @objc private func didTapTakePhoto() {
        //Can modify quality and other options here
        output.capturePhoto(with: AVCapturePhotoSettings(),
                            delegate: self)
    }
}

extension ViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else {
            return
        }
        let image = UIImage(data: data)
        session?.stopRunning()
        
//        let imageView = UIImageView(image: image)
        
        // Now, add text and picture to subview
        imageView.image = image
        view.addSubview(label)
        view.addSubview(imageView)

        recognizeText(image: image);
        
//        imageView.contentMode = .scaleAspectFill // Avoid distortion maintain ratio
//        imageView.frame = view.bounds
//        view.addSubview(imageView)
    }
}
