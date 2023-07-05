//
//  PDFDocumentModel.swift
//  DocumentScanner
//
//  Created by BJIT-24 on 19/6/23.
//

import Foundation

struct ScannedDocument: Codable,Hashable {
    var documentName: String?
    var thumnail: Data?
    var id: Int?
    var date: Date = Date()
    
}
