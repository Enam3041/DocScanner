//
//  StoreManager.swift
//  DocumentScanner
//
//  Created by BJIT-24 on 5/6/23.
//


import Foundation

enum StoreKeys: String{
    case scannedDocumetList = "stored_SannedDocumentList"
    case recognizedTextList = "stored_RecognizedTextList"
}

class StoreManager: NSObject{
    let storage = UserDefaults.standard
    
    func loadModel<T:Decodable>(model: T.Type, key: StoreKeys) -> T?{
        if let jsonData = self.storage.object(forKey: key.rawValue) as? Data
        {
            if let model = ModelParser().decode(data: jsonData, model: T.self)
            {
                return model
            }
        }
        
        return nil
    }
    
    func saveModel<T:Encodable>(model: T, key: StoreKeys)
    {
        if let jsonData = ModelParser().encode(model: model)
        {
            self.storage.set(jsonData, forKey: key.rawValue)
        }
    }
}

class ModelParser: NSObject{
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    func encode<T:Encodable>(model: T) -> Data?
    {
        if let jsonData = try? self.encoder.encode(model)
        {
            return jsonData
        }
        
        return nil
    }
    
    func decode<T:Decodable>(data:Data, model: T.Type) -> T?{
        do{
            let model = try self.decoder.decode(T.self, from: data)
            return model
        }
        catch {
            print("Unexpected error: \(error).")
        }
        return nil
    }
}
