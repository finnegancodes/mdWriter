//
//  mdWriterApp.swift
//  mdWriter
//
//  Created by Adam Oravec on 21/12/2022.
//

import SwiftUI

@main
struct mdWriterApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: MdFile()) { file in
            MainView(document: file.$document)
        }
#if !os(iOS)
        .defaultSize(width: 700, height: 500)
        .commands {
            TextEditingCommands()
            TextFormattingCommands()
        }
#endif
        
#if os(macOS)
        Settings {
            SettingsView()
        }
        .defaultPosition(.center)
#endif
    }
}
