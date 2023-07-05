//
//  TextItem.swift
//  DocumentScanner
//
//  Created by BJIT-24 on 5/6/23.
//

import Foundation

class RecognizedText: Codable,Identifiable {


    var id: String
    var text: String = ""
    var date: Date

    init() {
        id = UUID().uuidString
        date = Date()
    }


}

extension RecognizedText : Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }

    static func == (lhs: RecognizedText, rhs: RecognizedText) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}


