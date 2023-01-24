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
                        HStack(spacing: 4) {
                            Text(heading.type.name)
                                .foregroundColor(.secondary)
                            Text(verbatim: heading.string)
                        }
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
                var prefixCount = 0
                
                for char in line {
                    if char == "#" {
                        prefixCount += 1
                        continue
                    }
                    break
                }
                
                if prefixCount > 6 {
                    continue
                }
                
                guard let headingType = MdHeadingType.init(rawValue: prefixCount) else {
                    continue
                }
                
                var heading = line.trimmingCharacters(in: .whitespacesAndNewlines)
                heading.removeFirst(prefixCount)
                heading.trimPrefix(" ")
                
                newHeadings.append(MdHeading(string: heading, line: index, type: headingType))
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
