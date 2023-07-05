//
//  TextRecognizerViewModel.swift
//  DocumentScanner
//
//  Created by BJIT-24 on 19/6/23.
//

import Foundation
import Vision


class TextRecognizerViewModel: ObservableObject {
    @Published var items = [RecognizedText]()

    func getRecognizedTexts(){
        items = HistoryManager.shared.recognizedTextList
    }

    func addRecognizedText(_ recognizedText:RecognizedText){
        items = HistoryManager.shared.addRecognizedText(recognizedText)
    }

    func deleteRecognizedText(_ recognizedText:RecognizedText){
        items = HistoryManager.shared.deleteRecognizedText(recognizedText)
    }

    
}
