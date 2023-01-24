//
//  SettingsView.swift
//  mdWriter
//
//  Created by Adam Oravec on 22/12/2022.
//

import SwiftUI
import CodeEditor

struct SettingsView: View {
    @AppStorage("editorTheme") private var editorTheme: String = CodeEditor.ThemeName.ocean.rawValue
    @AppStorage("fontSize") private var fontSize: Int = 14
    
    var body: some View {
        Form {
            Section("General") {
                Picker("Theme", selection: $editorTheme) {
                    ForEach(CodeEditor.availableThemes) { theme in
                        Text("\(theme.rawValue)")
                            .tag(theme.rawValue)
                    }
                }
                
                Picker("Font size", selection: $fontSize) {
                    ForEach(11..<41) { i in
                        Text("\(i)").tag(i)
                    }
                }
                .pickerStyle(.menu)
            }
            Section("About") {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Created by [@finnegancodes](https://github.com/finnegancodes)")
                    Text("Source code: [github.com/finnegancodes/mdWriter](https://github.com/finnegancodes/mdWriter)")
                    Text("My website: [finnswonderland.eu](https://finnswonderland.eu)")
                }
            }
        }
        .formStyle(.grouped)
        .frame(width: 400, height: 280, alignment: .leading)
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
