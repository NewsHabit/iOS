//
//  DailyGoal.swift
//  NewsHabit
//
//  Created by 지연 on 3/9/25.
//

import Foundation

enum DailyGoal: Int, CaseIterable {
    case three = 3
    case four = 4
    case five = 5
    
    var desctiption: String {
        switch self {
        case .three:    "뉴스 읽는 즐거움을 느껴보세요"
        case .four:     "꾸준히 뉴스 습관을 만들어 보세요"
        case .five:     "뉴스 습관을 완성해 보세요"
        }
    }
    
    var count: String {
        "\(self.rawValue)개"
    }
}
