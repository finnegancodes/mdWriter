//
//  ContentView.swift
//  mdWriter
//
//  Created by Adam Oravec on 21/12/2022.
//

import SwiftUI

struct MainView: View {
    @Binding var document: MdFile
    @State var selectedLine: Int = 0
    @State private var editorMode: EditorMode = .edit
    
    var body: some View {
        NavigationSplitView {
            VStack {
                Picker("", selection: $editorMode) {
                    Text("Edit").tag(EditorMode.edit)
                    Text("Preview").tag(EditorMode.preview)
                }
                .pickerStyle(.segmented)
                .padding(.trailing, 8)
                .padding(.bottom, 8)
                
                
                OutlinerView(document: $document, selectedLine: $selectedLine)
            }
            .navigationSplitViewColumnWidth(min: 170, ideal: 180, max: 230)
        } detail: {
            EditorView(document: $document, editorMode: $editorMode, selectedLine: $selectedLine)
                .navigationSplitViewColumnWidth(min: 300, ideal: 600)
        }
#if os(macOS)
        .frame(minWidth: 500, minHeight: 200)
#endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(document: .constant(MdFile(initialContent: "Hi")))
    }
}
