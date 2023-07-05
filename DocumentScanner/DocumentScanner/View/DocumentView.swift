//
//  ContentView.swift
//  DocumentScanner
//
//  Created by BJIT-24 on 5/6/23.
//

import SwiftUI

struct DocumentView: View {
    
    @ObservedObject var scannedDocVM = ScannedDocumentViewModel()
    @State private var showScanner = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack{
                    List {
                        ForEach(scannedDocVM.documents, id: \.self) { document in
                            NavigationLink(destination: DocumentPreview(document: document)) {
                                DocumentCell(document: document)
                            }
                        }.onDelete(perform: removeRows)
                    }.toolbar {
                        EditButton()
                    }
                }
            }
            .navigationTitle("History")
            .navigationBarItems(trailing: Button(action: {
                showScanner = true
            }, label: {
                Image(systemName: "doc.text.viewfinder")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .frame(width: 24,height: 24)
                    .padding(.all, 6)
                    .background(Color(hex: 0x000000))
                    .cornerRadius(10)
            }))
        }.onAppear(){
            scannedDocVM.getScannedDocumets()
        }
        .fullScreenCover(isPresented: $showScanner, content: {
            ScannerView { result in
                switch result {
                case .success(let scannedImages):
                    scannedDocVM.addScannedDocument(scannedImages)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                showScanner = false
                
            } didCancelScanning: {
                showScanner = false
            }
        })
    }

    func removeRows(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        scannedDocVM.deleteScannedDocument(scannedDocVM.documents[index])
    }
}

struct DocumentView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentView()
    }
}


extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
