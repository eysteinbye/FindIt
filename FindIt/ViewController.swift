//
//  ViewController.swift
//  FindIt
//
//  Created by Eystein Bye on 08/06/2017.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func loadImage(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            
            let model = try! VNCoreMLModel(for: Inceptionv3().model)
            let request = VNCoreMLRequest(model: model, completionHandler: showResult)
            
            let cgImage = converToCGImage(image: pickedImage)
            let handler = VNImageRequestHandler(cgImage: cgImage)
            try! handler.perform([request])
        }
        dismiss(animated: true, completion: nil)
    }
    
    func showResult(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation]
            else { fatalError("Error") }
        
        if let bestMatch = results.first {
            descLabel.text = showResult(confidence: bestMatch.confidence, object: bestMatch.identifier)
        }
        
        for classification in results {
            print(classification.identifier, classification.confidence)
        }
    }
    
    private func showResult(confidence: VNConfidence, object: String) -> String {
        if (confidence.isLess(than: 0.1)) { return "I don´t know what this is" }
        if (confidence.isLess(than: 0.3)) { return "Could this be \(object)?" }
        if (confidence.isLess(than: 0.5)) { return "This must be \(object)" }
        return "This is \(object)"
    }
    
    private func converToCGImage(image: UIImage) -> CGImage {
        let inputImage = CIImage(image: image)
        let context = CIContext(options: nil)
        return context.createCGImage(inputImage!, from: inputImage!.extent)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
