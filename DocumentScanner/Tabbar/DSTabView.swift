//
//  DSTabView.swift
//  DocumentScanner
//
//  Created by BJIT-24 on 5/6/23.
//

import SwiftUI

struct DSTabView: View {
    @State private var selection = 0
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            TabView(selection: $selection) {
                DocumentView()
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .tabItem {
                        Image(systemName: "doc.viewfinder")
                        Text("Document Scanner")
                    }.tag(0)
                
                TextScannerView()
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .tabItem {
                        Image(systemName: "bookmark.circle.fill")
                        Text("Text Scanner")
                    }.tag(1)
                
                Text("Settings")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Settings")
                    }.tag(3)
                
            }.accentColor(.green)
                .onAppear() {
                }
            
        }
    }
}

struct DSTabView_Previews: PreviewProvider {
    static var previews: some View {
        DSTabView()
    }
}
