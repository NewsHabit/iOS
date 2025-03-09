//
//  Category.swift
//  NewsHabit
//
//  Created by 지연 on 3/7/25.
//

import Foundation

enum Category: CaseIterable {
    case politics
    case economy
    case society
    case world
    case lifestyle
    case science
    
    var name: String {
        switch self {
        case .politics:     "정치"
        case .economy:      "경제"
        case .society:      "사회"
        case .world:        "세계"
        case .lifestyle:    "생활/문화"
        case .science:      "IT/과학"
        }
    }
}
