//
//  DocumentPreview.swift
//  DocumentScanner
//
//  Created by BJIT-24 on 19/6/23.
//

import SwiftUI
import Foundation
import PDFKit

struct DocumentCell: View {
    var document: ScannedDocument
    
    var body: some View {
        HStack(spacing:10){
            Image(uiImage: UIImage(data: document.thumnail!)!)
                .resizable()
                .renderingMode(.original)
                .frame(width: 100,height: 100)
                .shadow(radius: 5)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                .overlay {
                    RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)).stroke(.orange, lineWidth: 2)
                }
                .padding(5)
            VStack(alignment: .leading,spacing: 5) {
                Text(document.documentName ?? "")
                    .font(.headline)
                Text(document.date,style: .date)
                    .font(.subheadline)
            }
            Spacer()
        }
    }
}

struct DocumentCell_Previews: PreviewProvider {
    static var previews: some View {
        DocumentCell(document: ScannedDocument())
    }
}
