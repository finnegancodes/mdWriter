//
//  OutlinerService.swift
//  mdWriter
//
//  Created by Adam Oravec on 22/12/2022.
//

import Foundation

struct MdHeading: Identifiable, Equatable {
    let id = UUID()
    let string: String
    let line: Int
    let type: MdHeadingType
}

enum MdHeadingType: Int, CaseIterable {
    case h1 = 1, h2, h3, h4, h5, h6
    
    var name: String {
        switch self {
        case .h1:
            return "h1"
        case .h2:
            return "h2"
        case .h3:
            return "h3"
        case .h4:
            return "h4"
        case .h5:
            return "h5"
        case .h6:
            return "h6"
        }
    }
}
