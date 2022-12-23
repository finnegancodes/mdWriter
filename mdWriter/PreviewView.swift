//
//  PreviewView.swift
//  mdWriter
//
//  Created by Adam Oravec on 22/12/2022.
//

import SwiftUI
import MarkdownUI

struct PreviewView: View {
    let document: MdFile
    private let previewDoc: Document
    
    init(document: MdFile) {
        self.document = document
        if let previewDoc = try? Document(markdown: document.content) {
            self.previewDoc = previewDoc
        } else {
            self.previewDoc = try! Document(markdown: "")
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Markdown(previewDoc)
            Spacer()
        }
        .padding(.all, 8)
    }
}

struct PreviewView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView(document: MdFile(initialContent: "Hello, World!"))
    }
}
