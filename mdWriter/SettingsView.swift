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
            Section {
                Picker("Theme", selection: $editorTheme) {
                    ForEach(CodeEditor.availableThemes) { theme in
                        Text("\(theme.rawValue)")
                            .tag(theme.rawValue)
                    }
                }
                .frame(maxWidth: 200)
                
                Picker("Font size", selection: $fontSize) {
                    ForEach(11..<41) { i in
                        Text("\(i)").tag(i)
                    }
                }
                .pickerStyle(.menu)
                .frame(maxWidth: 150)
            }
            Spacer()
        }
        .frame(width: 500, height: 300, alignment: .leading)
        .padding(.all)
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
