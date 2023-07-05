//
//  TextRecognizer.swift
//  DocumentScanner
//
//  Created by BJIT-24 on 4/7/23.
//

import SwiftUI
import Vision

struct TextRecognizer {
    var scannedImages: [UIImage]
    @ObservedObject var textRecognizerVM: TextRecognizerViewModel
    var didFinishRecognition: () -> Void
    
    func recognizeText() {
        let queue = DispatchQueue(label: "textRecognitionQueue", qos: .userInitiated)
        queue.async {
            for image in scannedImages {
                guard let cgImage = image.cgImage else { return }
                
                let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
                
                do {
                    let recognizedText = RecognizedText()
                    try requestHandler.perform([getTextRecognitionRequest(with: recognizedText)])
                    
                    DispatchQueue.main.async {
                        textRecognizerVM.addRecognizedText(recognizedText)
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    didFinishRecognition()
                }
            }
        }
    }
    
    private func getTextRecognitionRequest(with recognizedText: RecognizedText) -> VNRecognizeTextRequest {
        let request = VNRecognizeTextRequest { request, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            observations.forEach { observation in
                guard let _recognizedText = observation.topCandidates(1).first else { return }
                recognizedText.text += _recognizedText.string
                recognizedText.text += "\n"
            }
        }
        
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        
        return request
    }
}
