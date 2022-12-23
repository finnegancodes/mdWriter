//
//  OutlinerView.swift
//  mdWriter
//
//  Created by Adam Oravec on 22/12/2022.
//

import SwiftUI

struct OutlinerView: View {
    @Binding var document: MdFile
    @Binding var selectedLine: Int
    @State private var headings = [MdHeading]()
    
    var body: some View {
        List {
            Section("Outliner") {
                ForEach(headings, id: \.id) { heading in
                    Button {
                        print("Line selected")
                        selectedLine = heading.line
                    } label: {
                        Text(verbatim: heading.string)
                    }
                    .buttonStyle(.plain)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .onAppear {
            headings = findHeadings(in: document.content)
        }
        .onChange(of: document.content) { newValue in
            headings = findHeadings(in: newValue)
        }
    }
    
    private func findHeadings(in markdown: String) -> [MdHeading] {
        let lines = markdown.components(separatedBy: .newlines)
        var newHeadings: [MdHeading] = []
        for (index, line) in lines.enumerated() {
            if line.hasPrefix("#") {
                let heading = line.trimmingCharacters(in: .whitespacesAndNewlines)
                newHeadings.append(MdHeading(string: heading, line: index))
            }
        }
        return newHeadings
    }
}

struct OutlinerView_Previews: PreviewProvider {
    static var previews: some View {
        OutlinerView(document: .constant(MdFile(initialContent: "Hi!")), selectedLine: .constant(0))
    }
}
