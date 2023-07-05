//
//  TextScannerView.swift
//  DocumentScanner
//
//  Created by BJIT-24 on 4/7/23.
//

import SwiftUI

struct TextScannerView: View {
    @ObservedObject var textRecognizerVM = TextRecognizerViewModel()
    @State private var showScanner = false
    @State private var isRecognizing = false

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack{
                    List {
                        ForEach(textRecognizerVM.items, id: \.self) { textItem in
                            NavigationLink(destination: TextPreviewView(text: textItem.text)) {
                                Text(String(textItem.text.prefix(50)).appending("..."))
                                    .font(.system(size: 25, weight: .semibold, design: .rounded))

                            }

                        }.onDelete(perform: removeRows)
                    }.toolbar {
                        EditButton()
                    }

                }
                if isRecognizing {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color(UIColor.systemIndigo)))
                        .padding(.bottom, 20)
                }

            }
            .navigationTitle("History")
            .navigationBarItems(trailing: Button(action: {
                guard !isRecognizing else { return }
                showScanner = true
            }, label: {
                Image(systemName: "doc.text.viewfinder")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .frame(width: 24,height: 24)
                    .padding(.all, 6)
                    .background(.black)
                    .cornerRadius(10)
            }))
        }.onAppear(){
            textRecognizerVM.getRecognizedTexts()
        }
        .fullScreenCover(isPresented: $showScanner, content: {
            ScannerView { result in
                switch result {
                case .success(let scannedImages):
                    isRecognizing = true

                    TextRecognizer(scannedImages: scannedImages, textRecognizerVM: textRecognizerVM){
                        isRecognizing = false
                    }
                    .recognizeText()

                    //   textRecognizerVM(scannedImages: scannedImages).recognizeText()


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
        textRecognizerVM.deleteRecognizedText(textRecognizerVM.items[index])
    }
}


struct TextScannerView_Previews: PreviewProvider {
    static var previews: some View {
        TextScannerView()
    }
}
