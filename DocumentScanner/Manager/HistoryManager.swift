//
//  HistoryManager.swift
//  DocumentScanner
//
//  Created by BJIT-24 on 19/6/23.
//

import Foundation

class HistoryManager: NSObject{
    
    static let shared = HistoryManager()
    
    // MARK: DOCUMENT
    var scanedDocumentList: [ScannedDocument]{
        get{
            return StoreManager().loadModel(model: [ScannedDocument].self, key: .scannedDocumetList) ?? []
        }
        set(newValue){
            StoreManager().saveModel(model: newValue, key: .scannedDocumetList)
        }
    }
    
    func addScannedDocument(_ scannedDoc: ScannedDocument)->[ScannedDocument]{
        var lists = self.scanedDocumentList
        var sd = scannedDoc
        sd.date = Date()
        lists.append(sd)
        self.scanedDocumentList = lists
        return lists
    }

    func deleteScannedDocument(_ scannedDoc: ScannedDocument)->[ScannedDocument]{
        var lists = self.scanedDocumentList.filter{$0.id != scannedDoc.id}
        self.scanedDocumentList = lists
        return lists
    }
    
    func clearScannedDocumentsHistory(){
        self.scanedDocumentList = []
    }
    
    public func getId() -> Int{
        var savedIds: [Int] = []
        self.scanedDocumentList.forEach { (sd) in
            savedIds.append(sd.id!)
        }
        var id = 0
        while savedIds.contains(id){
            id = Int.random(in: 0 ... 100000)
        }
        return id
    }
    
    // MARK: TEXT
    
    var recognizedTextList: [RecognizedText]{
        get{
            return StoreManager().loadModel(model: [RecognizedText].self, key: .recognizedTextList) ?? []
        }
        set(newValue){
            StoreManager().saveModel(model: newValue, key: .recognizedTextList)
        }
    }
    
    func addRecognizedText(_ recognizedText: RecognizedText)->[RecognizedText]{
        var lists = self.recognizedTextList
        lists.append(recognizedText)
        self.recognizedTextList = lists
        return lists
    }

    func deleteRecognizedText(_ recognizedText: RecognizedText)->[RecognizedText]{
        var lists = self.recognizedTextList.filter{$0.id != recognizedText.id}
        self.recognizedTextList = lists
        return lists
    }

    func clearRecognizedTextsHistory(){
        self.recognizedTextList = []
    }

}
