//
//  DocumentPreview.swift
//  DocumentScanner
//
//  Created by BJIT-24 on 19/6/23.
//

import SwiftUI

struct DocumentPreview: View {
    var document: ScannedDocument
    
    var body: some View {
        VStack{
            Image(systemName: "doc.viewfinder")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("PDF Viewer")
                .foregroundColor(.accentColor)
            PDFKitView(id: document.id!)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                .overlay {
                    RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)).stroke(.orange, lineWidth: 2)
                }
            
        }.padding()
        
    }
}

struct DocumentPreview_Previews: PreviewProvider {
    static var previews: some View {
        DocumentPreview(document: ScannedDocument())
    }
}
