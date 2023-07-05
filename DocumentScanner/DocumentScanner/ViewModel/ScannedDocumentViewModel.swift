//
//  ScannedDocumentViewModel.swift
//  DocumentScanner
//
//  Created by BJIT-24 on 19/6/23.
//

import Foundation
import PDFKit

class ScannedDocumentViewModel: ObservableObject {
    @Published var documents = [ScannedDocument]()
    
    func getScannedDocumets(){
        documents = HistoryManager.shared.scanedDocumentList
    }
    
    func addScannedDocument(_ scannedImages:[UIImage]){
        guard let pdfDocument = scannedImages.makePDF()  else {
            return
        }
        let id = HistoryManager().getId()
        let data = pdfDocument.dataRepresentation()
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let docURL = documentDirectory.appendingPathComponent("\(id).pdf")
        do{
            print("docURL: \(docURL)")
            try data?.write(to: docURL)
            var doc = ScannedDocument()
            doc.documentName = "Scan \(HistoryManager.shared.scanedDocumentList.count + 1)"
            doc.id = id
            doc.thumnail = pdfThumbnail(pdfDocument)
            documents = HistoryManager.shared.addScannedDocument(doc)
        }catch(let error){
            print("error is \(error.localizedDescription)")
        }
    }

    func deleteScannedDocument(_ scannedDocument:ScannedDocument){
        documents = HistoryManager.shared.deleteScannedDocument(scannedDocument)
    }
    
    func pdfThumbnail(_ document:PDFDocument ,width: CGFloat = 60) -> Data? {
        guard let page = document.page(at: 0) else {
            return nil
        }
        let pageSize = page.bounds(for: .mediaBox)
        let pdfScale = width / pageSize.width
        let scale = UIScreen.main.scale * pdfScale
        let screenSize = CGSize(width: pageSize.width * scale,
                                height: pageSize.height * scale)
        
        return page.thumbnail(of: screenSize, for: .mediaBox).pngData()
    }
    
    
}


extension Array where Element: UIImage {
    
    func makePDF()-> PDFDocument? {
        let pdfDocument = PDFDocument()
        for (index,image) in self.enumerated() {
            let pdfPage = PDFPage(image: image)
            pdfDocument.insert(pdfPage!, at: index)
        }
        return pdfDocument
    }
}
