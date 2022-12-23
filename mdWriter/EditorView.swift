//
//  EditorView.swift
//  mdWriter
//
//  Created by Adam Oravec on 22/12/2022.
//

import SwiftUI
import CodeEditor

struct EditorView: View {
    @Binding var document: MdFile
    @Binding var editorMode: EditorMode
    @Binding var selectedLine: Int
        
    @AppStorage("fontSize") private var fontSize: Int = 14
    @AppStorage("editorTheme") private var editorTheme: String = CodeEditor.ThemeName.ocean.rawValue
    
    @State private var showingExporter = false
    @State private var showingExported = false
    @State private var selection = "".endIndex..<"".startIndex
    
    var body: some View {
        VStack(alignment: .leading) {
            if editorMode == .edit {
                CodeEditor(source: $document.content, selection: $selection, language: .markdown, theme: CodeEditor.ThemeName(rawValue: editorTheme), fontSize: .init(get: {CGFloat(fontSize)}, set: {fontSize = Int($0)}), flags: [ .selectable, .editable, .smartIndent ], autoPairs: ["(" : ")", "[" : "]"])
            } else {
                ScrollView {
                    PreviewView(document: document)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showingExporter = true
                } label: {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
                .keyboardShortcut("e", modifiers: [.command])
            }
        }
        .fileExporter(isPresented: $showingExporter, document: document, contentType: .markdown, defaultFilename: document.name, onCompletion: { result in
            switch result {
            case .success(let url):
                print("Saved to \(url)")
                showingExported = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        .alert("File exported", isPresented: $showingExported) {
            Button("OK", action: {})
        }
        .onChange(of: selectedLine) { newIndex in
            print("Cursor position changed:", newIndex)
            jump(to: newIndex)
        }
    }
    
    func jump(to index: Int) {
        let md = document.content
        let lines = document.content.components(separatedBy: .newlines)
        let line = lines[index]
        if let range = md.firstRange(of: line) {
            selection = range
        }
    }
}

struct EditorView_Previews: PreviewProvider {
    static var previews: some View {
        EditorView(document: .constant(MdFile(initialContent: "Hi")), editorMode: .constant(.preview), selectedLine: .constant(0))
    }
}
