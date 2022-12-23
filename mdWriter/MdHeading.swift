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
}
