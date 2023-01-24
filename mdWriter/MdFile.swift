//
//  MdFile.swift
//  mdWriter
//
//  Created by Adam Oravec on 21/12/2022.
//

import Foundation
import UniformTypeIdentifiers
import SwiftUI

extension UTType {
    static var markdown: UTType {
        UTType(importedAs: "eu.finnswonderland.mdWriter.md")
    }
}

struct MdFile: FileDocument {
    static var readableContentTypes = [UTType.markdown]
    
    var content = ""
    var name = ""
    
    init(initialContent: String = "") {
        self.content = initialContent
        self.name = "Untitled"
    }
    
    init(configuration: ReadConfiguration) throws {
        if let name = configuration.file.filename {
            self.name = name
        } else {
            throw CocoaError(.fileReadInvalidFileName)
        }
        if let data = configuration.file.regularFileContents {
            self.content = String(decoding: data, as: UTF8.self)
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(content.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}
