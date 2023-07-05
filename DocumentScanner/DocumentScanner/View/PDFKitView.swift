//
//  PDFKitView.swift
//  DocumentScanner
//
//  Created by BJIT-24 on 4/7/23.
//

import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {
    let id: Int
    func makeUIView(context: UIViewRepresentableContext<PDFKitView>) -> PDFView {
        guard let url = getDocumentUrl() else { return PDFView() }
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        pdfView.displayMode = .singlePageContinuous
        pdfView.autoScales = true
        pdfView.displayDirection = .horizontal
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: UIViewRepresentableContext<PDFKitView>) {}
    
    func getDocumentUrl()->URL? {
        do {
            let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
            for url in contents {
                print("url:\(url)")
                if url.description.contains("\(id).pdf") {
                    return url
                }
            }
        } catch {
            print("could not locate pdf file !!!!!!!")
        }
        return nil
    }
    
}
